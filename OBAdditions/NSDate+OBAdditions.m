//
//  NSDate+OBAdditions.m
//
//  Created by Oriol Blanc on 16/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

#import "NSDate+OBAdditions.h"

@implementation NSDate (OBAdditions)

+ (NSDateFormatter *)dateFormatterWithUserLanguage
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    NSString *preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:preferredLanguage] autorelease];
    
    [dateFormatter setLocale:locale];
    
    return dateFormatter;
}

- (NSString *)formattedDateString
{
    NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [NSDate dateFormatterWithUserLanguage];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)formattedDateAndTimeString
{
    NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [NSDate dateFormatterWithUserLanguage];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        
    }
    
    return [dateFormatter stringFromDate:self];
}

- (id)initWithDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year
{
    NSDateFormatter *dateFormatter = [NSDate dateFormatterWithUserLanguage];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateToTransform = [NSString stringWithFormat:@"%i/%i/%i", 
                                 day, month, year];
    return [[dateFormatter dateFromString:dateToTransform] retain];
}

- (NSUInteger)day
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    return [components day];
}

- (NSString *)getDayOfTheWeek
{
    NSDateFormatter *dateFormatter = [NSDate dateFormatterWithUserLanguage];
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSString *res = [dateFormatter stringFromDate:self];
    return res;
}

- (NSUInteger)month
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    return [components month];
}

- (NSUInteger)year
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    return [components year];
}

- (NSString *)getTimeString
{
    return [self stringByFormattedDate:@"HH:mm"];
}

- (NSString *)stringByFormattedDate:(NSString *)formattedDate
{
     NSDateFormatter *dateFormatter = nil;
    
    if (!dateFormatter)
    {
        dateFormatter = [NSDate dateFormatterWithUserLanguage];
    }

    dateFormatter.dateFormat = formattedDate;
        
    NSString *formattedDateString = [dateFormatter stringFromDate:self];
    
    return formattedDateString;
}

- (NSString *)remainingTimeString
{
    NSTimeInterval timeIntervalFromNow = MAX([self timeIntervalSinceNow], 0);
    NSString *timeRemainingString;
    
    int days    = floor(timeIntervalFromNow / 86400);
    int weeks   = floor(days/7);
    int months  = floor(weeks/4);
    int years   = floor(months/12);
    int hours   = floor(timeIntervalFromNow / 3600);
    int minutes = floor(timeIntervalFromNow / 60);
    
    if (years >= 1) {
        NSString *timelapse = years == 1 ? NSLocalizedString(@"Year", @"") : NSLocalizedString(@"Years", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", years, timelapse];
    } else if (months >= 1) {
        NSString *timelapse = months == 1 ? NSLocalizedString(@"Month", @"") : NSLocalizedString(@"Months", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", months, timelapse];        
    } else if (weeks >= 1) {
        NSString *timelapse = weeks == 1 ? NSLocalizedString(@"Week", @"") : NSLocalizedString(@"Weeks", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", weeks, timelapse];        
    } else if (days >= 1) {
        NSString *timelapse = days == 1 ? NSLocalizedString(@"Day", @"") : NSLocalizedString(@"Days", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", days, timelapse];        
    } else if (hours >= 1) {
        NSString *timelapse = hours == 1 ? NSLocalizedString(@"Hour", @"") : NSLocalizedString(@"Hours", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", hours, timelapse];        
    } else if (minutes >= 1) {
        NSString *timelapse = minutes == 1 ? NSLocalizedString(@"Minute", @"") : NSLocalizedString(@"Minutes", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", minutes, timelapse];    
    } else {
        timeRemainingString = NSLocalizedString(@"NoTime", nil);
    }
    
    return timeRemainingString;
}

- (NSString *)timeAgoString
{
    NSTimeInterval timeIntervalFromNow = MAX(-[self timeIntervalSinceNow], 0);
        
    NSString *timeRemainingString;
    
    int days    = floor(timeIntervalFromNow / 86400);
    int weeks   = floor(days/7);
    int months  = floor(weeks/4);
    int years   = floor(months/12);
    int hours   = floor(timeIntervalFromNow / 3600);
    int minutes = floor(timeIntervalFromNow / 60);
    int seconds = timeIntervalFromNow;
    
    if (years >= 1) {
        NSString *timelapse = years == 1 ? NSLocalizedString(@"Year", @"") : NSLocalizedString(@"Years", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", years, timelapse];
    } else if (months >= 1) {
        NSString *timelapse = months == 1 ? NSLocalizedString(@"Month", @"") : NSLocalizedString(@"Months", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", months, timelapse];        
    } else if (weeks >= 1) {
        NSString *timelapse = weeks == 1 ? NSLocalizedString(@"Week", @"") : NSLocalizedString(@"Weeks", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", weeks, timelapse];        
    } else if (days >= 1) {
        NSString *timelapse = days == 1 ? NSLocalizedString(@"Day", @"") : NSLocalizedString(@"Days", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", days, timelapse];        
    } else if (hours >= 1) {
        NSString *timelapse = hours == 1 ? NSLocalizedString(@"Hour", @"") : NSLocalizedString(@"Hours", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", hours, timelapse];        
    } else if (minutes >= 1) {
        NSString *timelapse = minutes == 1 ? NSLocalizedString(@"Minute", @"") : NSLocalizedString(@"Minutes", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", minutes, timelapse];    
    } else {
        NSString *timelapse = seconds == 1 ? NSLocalizedString(@"Second", @"") : NSLocalizedString(@"Seconds", @"");
        timeRemainingString = [NSString stringWithFormat:@"%d %@", seconds, timelapse]; 
    }
    
    return timeRemainingString;
}

- (BOOL)isToday
{
    NSDate * today = [NSDate date];
    
    NSString * todayString = [[today descriptionWithLocale:[NSLocale systemLocale]] substringToIndex:12];
    NSString * selfString = [[self descriptionWithLocale:[NSLocale systemLocale]] substringToIndex:12];
    
    return [selfString isEqualToString:todayString];
}

- (BOOL)isTomorrow
{
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:86400];
    
    NSString * yesterdayString = [[yesterday descriptionWithLocale:[NSLocale systemLocale]] substringToIndex:12];
    NSString * selfString = [[self descriptionWithLocale:[NSLocale systemLocale]] substringToIndex:12];
    
    return [selfString isEqualToString:yesterdayString];
}

- (NSDate *)dateByMovingToBeginningOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
        NSLog(@"the current date is %@", [[NSCalendar currentCalendar] dateFromComponents:parts]);
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)dateByMovingToEndOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)floor 
{
    // Returns an NSDate that is the same day as the receiver, but
    // with a time component of 00:00:00
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *overshootComponents = [gregorian components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self];
    
    [gregorian release];
    
    NSTimeInterval overshotByHours = [overshootComponents hour] * 60 * 60;
    NSTimeInterval overshotByMinutes = [overshootComponents minute] * 60;
    NSTimeInterval overshotBySeconds = [overshootComponents second];
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate];
    NSTimeInterval floorInterval = interval - (overshotByHours + overshotByMinutes + overshotBySeconds);
    
    NSDate *floorDate = [[[NSDate alloc] initWithTimeIntervalSinceReferenceDate:floorInterval] autorelease];
    
    return floorDate;
}

- (NSDate *)ceil 
{    
    // Returns an NSDate that is the same day as the receiver, but
    // with a time component of 11:59:59
    
    NSDate *floorDate = [self floor];
    NSTimeInterval secondsInADay = 86400;
    NSDate *ceilDate = [floorDate dateByAddingTimeInterval:secondsInADay-1];
    
    return ceilDate;    
}

+ (NSDate *)randomPastDate
{
    return [NSDate dateWithTimeIntervalSinceNow:[NSNumber randomIntBetweenNumber:0 andNumber:10000]];
}

+ (NSTimeInterval)randomUnixTimeOfPastDate
{
    return [[self randomPastDate] timeIntervalSince1970];
}

@end 