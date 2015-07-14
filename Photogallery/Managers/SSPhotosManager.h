//
//  SSPhotosManager.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPhotosManager : NSObject

/*!
 @property		searchOriginLocation
 @abstract		The users current location
 */
@property (nonatomic, assign) CLLocation *searchOriginLocation;

/*!
 @property		preferredSearchRadius
 @abstract		The radius of search area
 */
@property (nonatomic, assign) CGFloat preferredSearchRadius;

/*!
 @method        fetchPhotosWithinCurrentLocationWithCompletionBlock
 @param			iCompletionBlock - completion block to tell the success/failure of the call
 @abstract      fetch photos from current location
 */
- (void)fetchPhotosWithinCurrentLocationWithCompletionBlock:(void (^)(BOOL iSucceeded, NSArray *photos))iCompletionBlock;

@end
