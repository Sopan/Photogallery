//
//  UIImageView+Download.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "UIImageView+Download.h"

@implementation UIImageView (Download)

- (void)downloadImageFromUrl:(NSString *)iUrlString {
    [self blackPlaceholder];
    static int aRetrycount = 0;
    if (aRetrycount < 3) {
        NSURL *anImageUrl = [NSURL URLWithString:iUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:anImageUrl];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *_urlresponse,
                                                   NSData *iResponseData,
                                                   NSError *iError) {
                                   if (iError == nil) {
                                       self.image = [UIImage imageWithData:iResponseData];
                                   } else {
                                       aRetrycount++;
                                       [self downloadImageFromUrl:iUrlString];
                                   }
                               }];
    }
}


- (void)blackPlaceholder {
    UIGraphicsBeginImageContext(self.frame.size);
    [[UIColor blackColor]setFill];
    UIRectFill(self.bounds);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
