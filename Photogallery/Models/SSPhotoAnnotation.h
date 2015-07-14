//
//  SSPhotoAnnotation.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSPhoto;

@interface SSPhotoAnnotation : NSObject <MKAnnotation>

/*!
 @property		coordinate
 @abstract		location coordinate
 */
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

/*!
 @property		instagramPhoto
 @abstract		instagram photo
 */
@property (nonatomic, strong) SSPhoto *instagramPhoto;

/*!
 @property		title
 @abstract		title of the image
 */
@property (nonatomic, copy) NSString *title;

/*!
 @property		subtitle
 @abstract		subtitle of the annotation info
 */
@property (nonatomic, copy) NSString *subtitle;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)iCoordinate;

@end
