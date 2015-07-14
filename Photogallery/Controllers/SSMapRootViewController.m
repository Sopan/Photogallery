//
//  SSRootViewController.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSMapRootViewController.h"
#import "SSPhotosManager.h"
#import "SSPhotosViewController.h"
#import "SSPhotoDetailViewController.h"
#import "SSPhoto.h"
#import "SSPhotoAnnotation.h"
#import "SSOverlayView.h"


#define kSSTutorialKey @"tutorialKey"
#define kSSAnnotationViewIdentifier @"MKPinAnnotationView"


@interface SSMapRootViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

/*!
 @property		photosManager
 @abstract		to instantiate SSPhotosManager class
 */
@property (nonatomic, strong) SSPhotosManager *photosManager;

/*!
 @property		photos
 @abstract		list of fetched photos
 */
@property (nonatomic, strong) NSArray *photos;

/*!
 @property		mapView
 @abstract		reference to a MKMapView to create a map
 */
@property (nonatomic, strong) MKMapView *mapView;

/*!
 @property		locationManager
 @abstract		locationManager object for tracking the location
 */
@property (nonatomic, strong) CLLocationManager *locationManager;

/*!
 @property		slider
 @abstract		to create a slider
 */
@property (nonatomic, strong) UISlider *slider;

/*!
 @property		tutorialView
 @abstract		view to display the initial tutorial view
 */
@property (nonatomic, strong) SSOverlayView *tutorialView;

/*!
 @property		mapTapGestureRecognizer
 @abstract		tap gesture to display list of images
 */
@property (nonatomic, strong) UITapGestureRecognizer *mapTapGestureRecognizer;

/*!
 @property		overlayViewTapGestureRecognizer
 @abstract		gesture to remove the tutorial view
 */
@property (nonatomic, strong) UITapGestureRecognizer *overlayViewTapGestureRecognizer;

@end

@implementation SSMapRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Location";
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    self.photosManager = [[SSPhotosManager alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44.0f, self.view.bounds.size.width, 44.0f)];
    self.slider.minimumValue = kSSMinimumValueInKm;
    self.slider.maximumValue = kSSMaximumValueInKm;
    self.slider.value = kSSDefaultSearchRadiusInKm;
    [self.slider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view insertSubview:self.slider aboveSubview:self.mapView];
    
    self.mapTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.mapView addGestureRecognizer:self.mapTapGestureRecognizer];
}


#pragma mark - UISlider Methods

- (void)sliderTouchEnded:(UISlider *)iSender {
    self.photosManager.preferredSearchRadius = iSender.value;
    self.photosManager.searchOriginLocation = self.mapView.userLocation.location;
    [self fetchPhotos];
}


- (void)sliderValueChanged:(UISlider *)iSender {
    NSArray *anAnnotationList = self.mapView.annotations;
    if (anAnnotationList.count > 0) {
        [self.mapView removeAnnotations:anAnnotationList];
    }
    [self.mapView removeOverlays:self.mapView.overlays];
    [self centerMapViewWithRadius:iSender.value];
}


#pragma mapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kSSTutorialKey] == NO) {
        [self addOverlayView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSSTutorialKey];
    }
    
    //Fetch Photos
    if (!self.photos.count) {
        //Set location
        [self centerMapViewWithRadius:kSSDefaultSearchRadiusInKm];
        self.photosManager.preferredSearchRadius = kSSDefaultSearchRadiusInKm;
        self.photosManager.searchOriginLocation = mapView.userLocation.location;
        
        [self fetchPhotos];
    }
}


- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [self showAlertWithTitle:nil message:kSSLocationErrorText];
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    MKPinAnnotationView *tappedAnnotationView = (MKPinAnnotationView *)view;
    SSPhotoAnnotation *tappedAnnotation = (SSPhotoAnnotation *)tappedAnnotationView.annotation;
    SSPhoto *tappedPhoto = tappedAnnotation.instagramPhoto;
    [self presentPhoto:tappedPhoto];
}


- (void)centerMapViewWithRadius:(CGFloat)radius {
    CGFloat radiusMultipliter = 1.3;  //We use a multiplier to show a little more than the exact radius of search
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location.coordinate,
                                                                      radius*radiusMultipliter,
                                                                      radius*radiusMultipliter
                                                                      );
    [self.mapView setRegion:newRegion];
}


- (MKAnnotationView *)mapView:(MKMapView *)iMapView viewForAnnotation:(id <MKAnnotation>)iAnnotation {
    MKPinAnnotationView *anAnnotationView = nil;

    if ([iAnnotation isKindOfClass:[SSPhotoAnnotation class]]) {
        SSPhotoAnnotation *aPhotoAnnotation = (SSPhotoAnnotation *)iAnnotation;
        anAnnotationView = (MKPinAnnotationView *)[iMapView dequeueReusableAnnotationViewWithIdentifier:kSSAnnotationViewIdentifier];
        
        if (!anAnnotationView) {
            anAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:iAnnotation reuseIdentifier:kSSAnnotationViewIdentifier];
            anAnnotationView.canShowCallout = YES;
            anAnnotationView.enabled = YES;
            
        } else {
            anAnnotationView.annotation = iAnnotation;
        }
        
        UIButton *aRightButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
        anAnnotationView.rightCalloutAccessoryView = aRightButton;
        UIImageView *aThumbnailImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 48.0f, 48.0f)];
        [aThumbnailImage downloadImageFromUrl:aPhotoAnnotation.instagramPhoto.photoThumbnailImageUrl];
        anAnnotationView.leftCalloutAccessoryView  = aThumbnailImage;
    }
    
    return anAnnotationView;
}


// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.mapView.showsUserLocation = YES;
}


#pragma mark - UIGestureRecognizer Methods

- (void)handleTapGesture:(UITapGestureRecognizer *)iGestureRecognizer {
    if (self.photos.count == 0) {
        return;
    }
    CGPoint aLocationInView = [iGestureRecognizer locationInView:self.mapView];
    id anObject = [self.mapView hitTest:aLocationInView withEvent:nil];
    if (![anObject isKindOfClass:[MKPinAnnotationView class]]) {
        //Present photos
        SSPhotosViewController *controller = [[SSPhotosViewController alloc] initWithPhotos:self.photos];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (void)removeTutorialView:(UITapGestureRecognizer *)iGestureRecognizer {
    self.tutorialView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.tutorialView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        [self.tutorialView removeFromSuperview];
    }];
}


#pragma mark - User Defined Methods

- (void)fetchPhotos {
    __weak typeof(self) aWeakSelf = self;
    [self.photosManager fetchPhotosWithinCurrentLocationWithCompletionBlock:^(BOOL iSucceeded, NSArray *iImageList) {
        if (iSucceeded) {
            if ([iImageList count] > 0) {
                //Show photos on map
                aWeakSelf.photos = iImageList;
                NSLog(@"Successfully downloaded %lu photos from instagram", (unsigned long)iImageList.count);
                
                [iImageList enumerateObjectsUsingBlock:^(SSPhoto *iPhoto, NSUInteger idx, BOOL *stop) {
                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(iPhoto.photoLatitude, iPhoto.photoLongitude);
                    iPhoto.distanceFromCurrentPoint = [self getPhotoDistance:coordinate];
                    
                    SSPhotoAnnotation *anAnnotation = [[SSPhotoAnnotation alloc] initWithLocation:coordinate];
                    anAnnotation.instagramPhoto = iPhoto;
                    anAnnotation.title = [NSString stringWithFormat:@"%.2f km by %@", [self getPhotoDistance:coordinate], iPhoto.photoUserName];
                    anAnnotation.subtitle = [NSString stringWithFormat:@"Filter: %@", iPhoto.photoFilterName];
                    [self.mapView addAnnotation:anAnnotation];
                    
                }];
            } else {
                [self showAlertWithTitle:kSSImageFetchFailed message:kSSTryAgainText];
            }
        } else {
            [self showAlertWithTitle:kSSImageFetchFailed message:kSSTryAgainText];
        }
    }];
}


- (void)presentPhoto:(SSPhoto *)photo {
    SSPhotoDetailViewController *controller = [[SSPhotoDetailViewController alloc] initWithPhoto:photo];
    [self.navigationController pushViewController:controller animated:YES];
}


- (CLLocationDistance)getPhotoDistance:(CLLocationCoordinate2D)iCoordinate {
    CLLocation *anAnnotationLocation = [[CLLocation alloc] initWithLatitude:iCoordinate.latitude longitude:iCoordinate.longitude];
    CLLocationDistance distance = [self.mapView.userLocation.location distanceFromLocation:anAnnotationLocation];
    CLLocationDistance distanceInKm = distance/1000;
    return distanceInKm;
}


- (void)addOverlayView {
    self.tutorialView = [[SSOverlayView alloc] initWithFrame:self.view.bounds message:kSSIntroductoryText];
    [self.view addSubview:self.tutorialView];
    
    self.overlayViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTutorialView:)];
    [self.tutorialView addGestureRecognizer:self.overlayViewTapGestureRecognizer];
    
    self.tutorialView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:0.4 animations:^{
        self.tutorialView.transform = CGAffineTransformIdentity;
    }];
}


- (void)showAlertWithTitle:(NSString *)iTitle message:(NSString *)iMessage {
    UIAlertController *anAlertController = [UIAlertController alertControllerWithTitle:iTitle message:iMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *anOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [anAlertController addAction:anOKAction];
    [self presentViewController:anAlertController animated:YES completion:nil];
}

@end
