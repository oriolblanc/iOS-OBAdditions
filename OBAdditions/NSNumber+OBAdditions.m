//
//  NSNumber+OBAdditions.m
//
//  Created by Oriol Blanc on 11/25/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//

#import "NSNumber+OBAdditions.h"

@implementation NSNumber (OBAdditions)

+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber
{
    if (minNumber > maxNumber) {
        return [self randomIntBetweenNumber:maxNumber andNumber:minNumber];
    }
    
    NSUInteger i = (arc4random() % (maxNumber - minNumber + 1)) + minNumber;
    return i;
}

+ (NSNumber *)randomNumberBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber
{
    return [NSNumber numberWithUnsignedInteger:[self randomIntBetweenNumber:minNumber andNumber:maxNumber]];
}

+ (BOOL)randomBool
{
    return (BOOL)([NSNumber randomIntBetweenNumber:0 andNumber:1] == 1);
}

+ (NSNumber *)randomBoolNumber
{
    return [NSNumber numberWithBool:[self randomBool]];
}

@end