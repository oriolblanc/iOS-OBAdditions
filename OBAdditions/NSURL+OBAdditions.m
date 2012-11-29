//
//  NSURL+OBAdditions.m
//
//  Created by Oriol Blanc on 29/11/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "NSURL+OBAdditions.h"

@implementation NSURL (OBAdditions)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
    if (![queryString length]) {
        return self;
    }
    
    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", [self absoluteString],
                           [self query] ? @"&" : @"?", queryString];
    NSURL *theURL = [NSURL URLWithString:URLString];
    [URLString release];
    return theURL;
}

@end
