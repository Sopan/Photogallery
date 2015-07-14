//
//  SSOverlayView.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSOverlayView : UIView

/*!
 @method        initWithFrame:message:
 @param			iFrame - frame of the view to be created
 @param			iMessage - message to be displayed on the view
 @abstract      instantiate the view with given frame and show appropriate message
 */
- (instancetype)initWithFrame:(CGRect)iFrame message:(NSString *)iMessage;

@end
