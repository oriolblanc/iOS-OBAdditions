//
//  NSNumber+OBAdditions.h
//
//  Created by Oriol Blanc on 11/25/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//


@interface NSNumber (OBAdditions)

+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber;
+ (NSNumber *)randomNumberBetweenNumber:(NSUInteger)minNumber andNumber:(NSUInteger)maxNumber;
+ (BOOL)randomBool;
+ (NSNumber *)randomBoolNumber;


@end
