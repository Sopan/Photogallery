//
//  NSDictionary+SafeCheck.h
//  Photogallery
//
//  Created by Sopan Sharma on 7/10/15.
//  Copyright (c) 2015 Sopan Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeCheck)

/*!
 @method        safeStringForKey
 @param			iKey - a key for an object in this dictionary
 @abstract      safely accesses the requested key and casts the value to a string, returns nil if anything fails
 */
- (NSString *)safeStringForKey:(NSString*)iKey;

/**
 *  safely accesses the requested key and casts the value to a string, returns nil if anything fails
 *
 *  @param iKey a key for an object in this dictionary
 *
 */
- (NSNumber *)safeNumberForKey:(NSString *)iKey;

/*!
 @method        safeDictionaryForKey
 @param			iKey - a key for an object in this dictionary
 @abstract      safely accesses the requested key and casts the value to a dictionary, returns nil if anything fails
 */
- (NSDictionary *)safeDictionaryForKey:(NSString*)iKey;

/*!
 @method        safeArrayForKey
 @param			iKey - a key for an object in this dictionary
 @abstract      safely accesses the requested key and casts the value to a array, returns nil if anything fails
 */
- (NSArray *)safeArrayForKey:(NSString*)iKey;

/*!
 @method        safeBOOLForKey
 @param			iKey - a key for an object in this dictionary
 @abstract      safely accesses the requested key and casts the value to a bool, returns nil if anything fails
 */
- (BOOL)safeBOOLForKey:(NSString*)iKey;

@end
