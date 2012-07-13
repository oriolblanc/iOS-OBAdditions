//
//  NSObject+OBAdditions.m
//
//  Created by Oriol Blanc Gimeno on 13/07/12.
//  Copyright (c) 2012 Fever, Inc. All rights reserved.
//

#import "NSObject+OBAdditions.h"

@implementation NSObject (OBAdditions)

- (id)performSelectorIfResponds:(SEL)aSelector
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector];
    }
    return NULL;
}

- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector withObject:anObject];
    }
    return NULL;
}


@end
