//
//  SSPhotosViewController.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSPhotosViewController.h"
#import "SSPhotoCollectionViewCell.h"
#import "SSPhotoDetailViewController.h"
#import "SSPhoto.h"

#define kSSPhotoCollectionViewCellIdentifier @"SSPhotoCollectionViewCellIdentifier"

@interface SSPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/*!
 @property		collectionView
 @abstract		collectionView to display all the photos
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/*!
 @property		photos
 @abstract		photos list which has been downloaded
 */
@property (nonatomic, strong) NSArray *photos;

@end


@implementation SSPhotosViewController

- (instancetype)initWithPhotos:(NSArray *)iPhotoList {
    if (self = [super init]) {
        self.photos = iPhotoList;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Gallery";
    self.view.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    aFlowLayout.minimumInteritemSpacing = 8;
    aFlowLayout.itemSize = CGSizeMake(96.0f, 156.0f);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kSSCollectionViewSidePadding, kSSCollectionViewSidePadding, self.view.bounds.size.width - 2*kSSCollectionViewSidePadding, self.view.bounds.size.height - 2*kSSCollectionViewSidePadding) collectionViewLayout:aFlowLayout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SSPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kSSPhotoCollectionViewCellIdentifier];
}


#pragma mark - UICollectionView Datasource

- (CGSize)collectionView:(UICollectionView *)iCollectionView layout:(UICollectionViewLayout *)iCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)iIndexPath {
    return CGSizeMake(96.0f, 156.0f);
}


- (NSInteger)collectionView:(UICollectionView *)iCollectionView numberOfItemsInSection:(NSInteger)iSection {
    return self.photos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)iCollectionView cellForItemAtIndexPath:(NSIndexPath *)iIndexPath {
    SSPhotoCollectionViewCell *aCollectionViewCell = (SSPhotoCollectionViewCell *)[iCollectionView dequeueReusableCellWithReuseIdentifier:kSSPhotoCollectionViewCellIdentifier forIndexPath:iIndexPath];
    
    SSPhoto *aPhoto = self.photos[iIndexPath.row];
    aCollectionViewCell.usernameLabel.text = [aPhoto.photoUserName capitalizedString];
    aCollectionViewCell.distanceLabel.text = [NSString stringWithFormat:@"%.2f km", aPhoto.distanceFromCurrentPoint];
    [aCollectionViewCell.imageView downloadImageFromUrl:aPhoto.photoLowQualityImageURL];
    return aCollectionViewCell;
}


#pragma mark = UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)iCollectionView didSelectItemAtIndexPath:(NSIndexPath *)iIndexPath {
    SSPhoto *aSelectedPhoto = self.photos[iIndexPath.row];
    SSPhotoDetailViewController *aDetailViewController = [[SSPhotoDetailViewController alloc] initWithPhoto:aSelectedPhoto];
    [self.navigationController pushViewController:aDetailViewController animated:YES];
}


@end
