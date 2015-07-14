//
//  SSPhotosViewController.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPhotosViewController : UIViewController

/*!
 @method        initWithPhotos:tappedPhotoIndex:
 @param			iPhotoList - list of the photo model objects
 @abstract      initialize the controller with photos to be displayed alng with the index tapped
 */
- (instancetype)initWithPhotos:(NSArray *)iPhotoList;

@end
