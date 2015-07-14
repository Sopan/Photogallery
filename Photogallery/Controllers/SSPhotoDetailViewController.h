//
//  SSPhotoDetailViewController.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPhoto;

@interface SSPhotoDetailViewController : UIViewController

/*!
 @method        initWithPhoto:
 @param			iPhoto - the selected photo
 @abstract      initialize the controller with the selected photo
 */
- (instancetype)initWithPhoto:(SSPhoto *)iPhoto;

@end
