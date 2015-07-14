//
//  NSDictionary+SafeCheck.m
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import "NSDictionary+SafeCheck.h"

static NSNumberFormatter *aNumberFormatter;

@implementation NSDictionary (SafeCheck)

- (BOOL)safeBOOLForKey:(NSString*)iKey {
    BOOL aReturnVal = NO;
    id anObject = [self valueForKeyPath:iKey];
    if ([anObject isKindOfClass:[NSString class]]) {
        aReturnVal = [anObject boolValue];
    }
    return aReturnVal;
}


- (NSString *)safeStringForKey:(NSString*)iKey {
    NSString *aReturnVal = nil;
    id anObject = [self valueForKeyPath:iKey];
    if ([anObject isKindOfClass:[NSString class]])
        aReturnVal = anObject;
    return aReturnVal;
}


- (NSNumber *)safeNumberForKey:(NSString *)iKey {
    NSNumber *aReturnVal = nil;
    id anObject = [self valueForKeyPath:iKey];
    if ([anObject isKindOfClass:[NSNumber class]]) {
        aReturnVal = anObject;
    } else if ([anObject isKindOfClass:[NSString class]]) {
        if (!aNumberFormatter) {
            aNumberFormatter = [[NSNumberFormatter alloc] init];
            [aNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        }
        aReturnVal = [aNumberFormatter numberFromString:anObject];
    }
    
    return aReturnVal;
}


- (NSDictionary*)safeDictionaryForKey:(NSString*)iKey {
    NSDictionary *aReturnVal = nil;
    id anObject = [self valueForKeyPath:iKey];
    if ([anObject isKindOfClass:[NSDictionary class]])
        aReturnVal = anObject;
    return aReturnVal;
}


- (NSArray*)safeArrayForKey:(NSString*)iKey {
    NSArray *aReturnVal = nil;
    id anObject = [self valueForKeyPath:iKey];
    if ([anObject isKindOfClass:[NSArray class]])
        aReturnVal = anObject;
    return aReturnVal;
}


@end
