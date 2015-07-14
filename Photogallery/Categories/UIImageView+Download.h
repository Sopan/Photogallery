//
//  UIImageView+Download.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)

/*!
 @method        downloadImageFromUrl
 @param			iUrlString - URL of the image to be downloaded
 @abstract      download the image based on the specific URL string
 */
- (void)downloadImageFromUrl:(NSString *)iUrlString;

@end
