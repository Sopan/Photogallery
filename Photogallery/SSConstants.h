//
//  SSConstants.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#ifndef Photogallery_SSConstants_h
#define Photogallery_SSConstants_h


#define SSSafeBlock(block, ...) block ? block(__VA_ARGS__) : nil


#define kSSMinimumValueInKm           20
#define kSSDefaultSearchRadiusInKm    1000
#define kSSMaximumValueInKm           4500
#define kSSCollectionViewSidePadding   8


// User Details
#define kSSInstagramClientId               @"2ab0af78587c4d4dacfcd89fffc843a2"
#define kSSInstagramClientSecret           @"8d94fa9e14714449994d31342b22c070"
#define kSSInstagramAPIServer              @"https://api.instagram.com"
#define kSSInstagramMediaSearchEndpoint    @"/v1/media/search"
#define kSSInstagramMediaInfoEndpoint      @"/media/%@"


// Texts
#define kSSIntroductoryText @"Tap on map to view all images and on right accessory button to view individual images."
#define kSSLocationErrorText @"Could not determine your location"
#define kSSImageFetchFailed @"Image Fetch Failed"
#define kSSTryAgainText @"Please try again after sometime"


#endif
