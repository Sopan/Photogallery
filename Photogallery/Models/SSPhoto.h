//
//  SSPhoto.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPhoto : NSObject

/*!
 @property		photoLatitude
 @abstract		latitude of the photo
 */
@property (readwrite, assign) CGFloat photoLatitude;

/*!
 @property		photoLongitude
 @abstract		longitude of the photo
 */
@property (readwrite, assign) CGFloat photoLongitude;

/*!
 @property		distanceFromCurrentPoint
 @abstract		photo distance from current point
 */
@property (nonatomic, assign) CLLocationDistance distanceFromCurrentPoint;

/*!
 @property		likesCount
 @abstract		number of likes to teh photo
 */
@property (readwrite, strong) NSString *likesCount;

/*!
 @property		photoThumbnailImageUrl
 @abstract		thumbnail image URL
 */
@property (nonatomic, strong) NSString *photoThumbnailImageUrl;

/*!
 @property		photoLowQualityImageURL
 @abstract		low quality image URL
 */
@property (nonatomic, strong) NSString *photoLowQualityImageURL;

/*!
 @property		photoStandardQualityImageURL
 @abstract		standard quality image URL
 */
@property (nonatomic, strong) NSString *photoStandardQualityImageURL;

/*!
 @property		photoFilterName
 @abstract		filter name of the photo
 */
@property (nonatomic, strong) NSString *photoFilterName;

/*!
 @property		photoUserName
 @abstract		user name of the photo
 */
@property (nonatomic, strong) NSString *photoUserName;

/*!
 @property		photoAssetType
 @abstract		assetType of the photo
 */
@property (nonatomic, strong) NSString *photoAssetType;

/*!
 @property		photoCaption
 @abstract		caption of the photo
 */
@property (nonatomic, strong) NSString *photoCaption;

/*!
 @property		cityName
 @abstract		city location of the photo
 */
@property (nonatomic, strong) NSString *cityName;

/*!
 @method        initWithDictionary
 @param			iData - data to be initialized with
 @abstract      initialize the model with given data
 */
- (instancetype)initWithDictionary:(NSDictionary *)iData;

@end
