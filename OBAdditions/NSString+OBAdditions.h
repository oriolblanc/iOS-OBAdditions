//
//  NSString+OBAdditions.h
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

@interface NSString (OBAdditions) 

- (NSString *)stringByParsingINGJSON:(NSString *)key;
- (NSDate *)getDateFromJSON;
- (NSString *)currencyCodeToSymbol;
- (NSString *)replaceCommasByPoints;
- (NSString *)replacePointsByCommas;
- (NSString *)deleteSpace;
- (NSString *)stringToSha1;
- (NSString *)stringToBase64;
- (BOOL)isEmpty;
- (BOOL)isNotEmpty;

+ (NSString *)randomStringWithLength:(int)length;
+ (NSString *)randomStringWithLengthBetween:(int)minLength and:(int)maxLength;

@end 
