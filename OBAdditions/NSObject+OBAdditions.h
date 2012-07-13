//
//  NSObject+OBAdditions.h
//
//  Created by Oriol Blanc Gimeno on 13/07/12.
//  Copyright (c) 2012 Fever, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OBAdditions)

- (id)performSelectorIfResponds:(SEL)aSelector;
- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject;

@end
