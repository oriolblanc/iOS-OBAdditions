//
//  NSString+OBAdditions.h
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

@interface NSString (OBAdditions) 

// check if string contains a substring
- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options;
- (BOOL)isValidEmail;
- (BOOL)isNumeric;

- (NSString *)capitalizeFirstLetter;

- (NSDate *)getDateFromJSON;
- (NSString *)currencyCodeToSymbol;
- (NSString *)replaceCommasByPoints;
- (NSString *)replacePointsByCommas;
- (NSString *)deleteSpace;
- (NSString *)trim;

// crpypt
- (NSString *)stringToSha1;
- (NSString *)stringToBase64;

// Check if string is empty
+ (BOOL)isStringEmpty:(NSString *)aString;
+ (BOOL)isStringNotEmpty:(NSString *)aString;

// Random
+ (NSString *)randomStringWithLength:(int)length;
+ (NSString *)randomStringWithLengthBetween:(int)minLength and:(int)maxLength;

@end 
