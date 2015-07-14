//
//  SSPhotoAnnotation.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSPhotoAnnotation.h"

@implementation SSPhotoAnnotation

- (instancetype)initWithLocation:(CLLocationCoordinate2D)iCoordinate {
    if (self = [super init]) {
        _coordinate = iCoordinate;
    }
    return self;
}


@end
