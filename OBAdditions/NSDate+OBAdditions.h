//
//  NSDate+OBAdditions.h
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

@interface NSDate (OBAdditions)

- (NSString *)formattedDateString;
- (NSString *)formattedDateAndTimeString;
- (id)initWithDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year;
- (NSUInteger)day;
- (NSString *)getDayOfTheWeek;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSString *)getTimeString;
- (NSString *)stringByFormattedDate:(NSString *)formattedDate;

- (NSString *)remainingTimeString;
- (NSString *)timeAgoString;

- (BOOL)isToday;
- (BOOL)isTomorrow;

- (NSDate *)dateByMovingToBeginningOfDay;
- (NSDate *)dateByMovingToEndOfDay;

- (NSDate *)floor;
- (NSDate *)ceil;

+ (NSDate *)randomPastDate;
+ (NSTimeInterval)randomUnixTimeOfPastDate;

@end 