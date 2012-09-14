//
//  NSObject+OBAdditions.h
//
//  Created by Oriol Blanc Gimeno on 13/07/12.
//  Copyright (c) 2012 Oriol Blanc, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OBAdditions)

- (id)performSelectorIfResponds:(SEL)aSelector;
- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject;

- (void)performBlock:(void (^)(void))block ifRespondsTo:(SEL)aSelector;
- (void)performBlock:(void (^)(id object))block withObject:(id)object ifRespondsTo:(SEL)aSelector;

@end
