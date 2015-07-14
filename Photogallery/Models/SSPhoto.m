//
//  SSPhoto.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSPhoto.h"

@implementation SSPhoto

- (instancetype)initWithDictionary:(NSDictionary *)iData {
    if (self = [super init]) {
        _photoAssetType = [iData safeStringForKey:@"type"];
        _photoLowQualityImageURL = [iData[@"images"][@"low_resolution"] safeStringForKey:@"url"];
        _photoThumbnailImageUrl = [iData[@"images"][@"thumbnail"] safeStringForKey:@"url"];
        _photoStandardQualityImageURL = [iData[@"images"][@"standard_resolution"] safeStringForKey:@"url"];
        _photoUserName = [iData[@"user"] safeStringForKey:@"username"];
        _photoFilterName = [iData safeStringForKey:@"filter"];
        _photoCaption = iData[@"caption"] != [NSNull null] ? [iData[@"caption"] safeStringForKey:@"text"] : @"";
        _photoLatitude = [[iData[@"location"] safeNumberForKey:@"latitude"] floatValue];
        _photoLongitude = [[iData[@"location"] safeNumberForKey:@"longitude"] floatValue];
        _likesCount = [[iData[@"likes"] safeNumberForKey:@"count"] stringValue];
        [self getCityNameUsingLatitude:_photoLatitude longitude:_photoLongitude];
    }
    
    return self;
}


- (void)getCityNameUsingLatitude:(CGFloat)iLatitude longitude:(CGFloat)iLongitude {
    CLLocation *aLocation = [[CLLocation alloc] initWithLatitude:iLatitude longitude:iLongitude];
    CLGeocoder *aGeocoder = [[CLGeocoder alloc] init] ;
    [aGeocoder reverseGeocodeLocation:aLocation completionHandler:^(NSArray *placemarks, NSError *iError) {
         if (iError) {
             NSLog(@"Geocode failed with error: %@", iError);
             _cityName = @"";
         } else {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             _cityName = placemark.locality;
         }
     }];
}

@end
