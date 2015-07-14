//
//  SSPhotoCollectionViewCell.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPhotoCollectionViewCell : UICollectionViewCell

/*!
 @property		imageView
 @abstract		thumbail image view
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/*!
 @property		usernameLabel
 @abstract		username label
 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

/*!
 @property		distanceLabel
 @abstract		distance from current location
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
