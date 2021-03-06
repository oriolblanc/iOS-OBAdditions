//
//  NSString+OBAdditions.m
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "NSString+OBAdditions.h"

#import "NSNumber+OBAdditions.h"

#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (OBAdditions)

+ (NSString *)truncatedStringForCount:(NSUInteger)count
{
    NSString *countString;
    
    if (count > 999999)
    {
        countString = [NSString stringWithFormat:@"%lum", (unsigned long) count / 1000000];
    }
    else if (count > 999)
    {
        NSUInteger rest = count % 1000;
        if (rest < 100)
        {
            countString = [NSString stringWithFormat:@"%luk", (unsigned long) count / 1000];
        }
        else
        {
            countString = [NSString stringWithFormat:@"%lu.%luk", ((unsigned long) count) / 1000 , ((unsigned long) rest) / 100];
        }
    }
    else
    {
        countString = [NSString stringWithFormat:@"%lu", (unsigned long) count];
    }
    
    return countString;
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options 
{
    return [self rangeOfString:string options:options].location != NSNotFound;
}

- (BOOL)containsString:(NSString *) string 
{
    return [self containsString:string options:0];
}

// http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
- (BOOL)isValidEmail
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidUsername
{
    NSString *usernameRegex = @"^[a-zA-Z0-9_]{3,15}$";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
    
    return [usernameTest evaluateWithObject:self];
}

- (BOOL)isNumeric
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    return [numberFormatter numberFromString:self] != nil;
}

- (BOOL)validRange:(NSRange)range
{    
    return ((range.location != NSNotFound && range.length != NSNotFound) &&
            (range.location <= self.length && range.length <= self.length) &&
            ((range.location + range.length) <= self.length));
}

- (NSString *)capitalizeFirstLetter
{
    return  [self stringByReplacingCharactersInRange:NSMakeRange(0,1)  
                                        withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSDate *)getDateFromJSON
{
	if (!self) 
	{
		return nil;
	}
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];// HH:mm:ss
    
    NSDate *date = [dateFormatter dateFromString:self];
    
    return date;
}

// "EUR" to "€"
- (NSString *)currencyCodeToSymbol{
    
    static const NSString *kDefaultCurrency = @"€";

	// http://www.xe.com/symbols.php
	if ([@"EUR" compare:self] == NSOrderedSame){
		return @"€";
	}
	if ([@"USD" compare:self] == NSOrderedSame){
		return @"$";
	}
	if ([@"AUD" compare:self] == NSOrderedSame){
		return @"$";
	}
	if ([@"CAD" compare:self] == NSOrderedSame){
		return @"$";
	}
	if ([@"GBP" compare:self] == NSOrderedSame){
		return @"£";
	}
	if ([@"JPY" compare:self] == NSOrderedSame){
		return @"¥";
	}
	return [NSString stringWithFormat:@"%@", kDefaultCurrency];
}

- (NSString *)replaceCommasByPoints
{
	return [self stringByReplacingOccurrencesOfString:@"," withString:@"."];
}
- (NSString *)replacePointsByCommas
{
    return [self stringByReplacingOccurrencesOfString:@"." withString:@","];
}

- (NSString *)deleteSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// Source http://stackoverflow.com/questions/1353771/trying-to-write-nsstring-sha1-function-but-its-returning-null
- (NSString *)stringToSha1{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    NSString *s = [NSString  stringWithFormat:
                   @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                   result[0], result[1], result[2], result[3], result[4],
                   result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11], result[12],
                   result[13], result[14], result[15],
                   result[16], result[17], result[18], result[19]
                   ];
    
    return [s lowercaseString];
}

- (NSString *)stringToBase64
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    if ([data length] == 0)
        return @"";
	
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
	
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
			buffer[bufferLength++] = ((char *)[data bytes])[i++];
		
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';        
    }
	
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString *)stringByReversingString
{
    __block NSMutableString *reversedString = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0,[self length])
                                 options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                              usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                  [reversedString appendString:substring];
                              }];
    
    return [NSString stringWithString:reversedString];
}

+ (BOOL)isStringEmpty:(NSString *)aString
{
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;  
}

+ (BOOL)isStringNotEmpty:(NSString *)aString
{
    return ![NSString isStringEmpty:aString];
}

+ (NSString *)randomStringWithLength:(NSUInteger)length
{
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%c", [letters characterAtIndex: arc4random()%letters.length]];
    }
         
    return randomString;
}

+ (NSString *)randomStringWithLengthBetween:(int)minLength and:(int)maxLength
{
    return [self randomStringWithLength:[NSNumber randomIntBetweenNumber:minLength andNumber:maxLength]];
}

@end
