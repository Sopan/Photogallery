//
//  SSPhotoDetailViewController.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSPhotoDetailViewController.h"
#import "SSPhoto.h"

@interface SSPhotoDetailViewController ()

/*!
 @property		photoImageView
 @abstract		to display selected image
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

/*!
 @property		photoCaptionLabel
 @abstract		caption to be displayed
 */
@property (weak, nonatomic) IBOutlet UILabel *photoCaptionLabel;

/*!
 @property		photoLocalityLabel
 @abstract		photo's locality
 */
@property (weak, nonatomic) IBOutlet UILabel *photoLocalityLabel;

/*!
 @property		photoLikeCountLabel
 @abstract		like count of the photos
 */
@property (weak, nonatomic) IBOutlet UILabel *photoLikeCountLabel;

/*!
 @property		photo
 @abstract		selected photo
 */
@property (nonatomic, strong) SSPhoto *photo;

@end

@implementation SSPhotoDetailViewController


- (instancetype)initWithPhoto:(SSPhoto *)iPhoto {
    if (self = [super init]) {
        self.photo = iPhoto;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.photo.photoUserName capitalizedString];
    self.view.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [self.photoImageView downloadImageFromUrl:self.photo.photoStandardQualityImageURL];
    self.photoCaptionLabel.text = self.photo.photoCaption;
    self.photoLocalityLabel.text = self.photo.cityName;
    self.photoLikeCountLabel.text = [NSString stringWithFormat:@"%@ likes", self.photo.likesCount];
}

@end
