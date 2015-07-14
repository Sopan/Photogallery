//
//  SSPhotosManager.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "SSPhotosManager.h"
#import "SSPhoto.h"

@implementation SSPhotosManager


- (NSString *)createServiceURLString {
    NSDictionary *theParameterData = @{@"distance":@(self.preferredSearchRadius),
                             @"lat":@(self.searchOriginLocation.coordinate.latitude),
                             @"lng":@(self.searchOriginLocation.coordinate.longitude),
                             @"client_id":kSSInstagramClientId
                             };
    
    NSString *aQuerystring = [self queryStringWithParams:theParameterData];
    
    return [NSString stringWithFormat:@"%@/%@%@", kSSInstagramAPIServer, kSSInstagramMediaSearchEndpoint, aQuerystring];
}


- (NSString *)queryStringWithParams:(NSDictionary *)iParameterData {
    NSString *aReturnValue = nil;
    
    if (iParameterData && [iParameterData allKeys].count > 0) {
        NSMutableString *parameterstring=[NSMutableString stringWithString:@"?"];
        
        [[iParameterData allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [parameterstring appendString:[NSString stringWithFormat:@"%@=%@",obj,iParameterData[obj]]];
            
            if (idx < [iParameterData allKeys].count - 1) {
                [parameterstring appendString:@"&"];
            }
        }];
        
        aReturnValue = [parameterstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
   
    return aReturnValue;
}


- (void)fetchPhotosWithinCurrentLocationWithCompletionBlock:(void (^)(BOOL iSucceeded, NSArray *photos))iCompletionBlock {
    NSURL *aUrl = [NSURL URLWithString:[self createServiceURLString]];
    NSMutableURLRequest *aRequest = [NSMutableURLRequest  requestWithURL:aUrl];
    NSLog(@"Fetching Data from instagram API for URL: %@", aUrl);
    
    [NSURLConnection sendAsynchronousRequest:aRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *iResponse, NSData *iResponseData, NSError *iError) {
                               
                               NSHTTPURLResponse *aHttpResponse = (NSHTTPURLResponse *)iResponse;
                               
                               if (!iError && aHttpResponse.statusCode == 200) {
                                   NSMutableDictionary *aResponseData = [NSMutableDictionary dictionary];
                                   NSError *jsonParseError = nil;
                                   aResponseData = [NSJSONSerialization JSONObjectWithData:iResponseData
                                                                                  options:NSJSONReadingMutableContainers
                                                                                    error:&jsonParseError];
                                   if (jsonParseError) {
                                       SSSafeBlock(iCompletionBlock, NO, nil);
                                   } else {
                                       NSMutableArray *aPhotoList = [NSMutableArray array];
                                       NSArray *aPhotosData = aResponseData[@"data"];
                                       
                                       NSLog(@"The photos response from API %@", aPhotosData);
                                       //Parse photos from JSONResponse
                                       for (NSDictionary *aPhotoData in aPhotosData){
                                           SSPhoto *aPhoto = [[SSPhoto alloc] initWithDictionary:aPhotoData];
                                           [aPhotoList addObject:aPhoto];
                                       }
                                       SSSafeBlock(iCompletionBlock, YES, (NSArray *)aPhotoList);
                                   }
                               } else {
                                   SSSafeBlock(iCompletionBlock, NO, nil);
                               }
                           }];
}



@end
