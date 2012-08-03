//
//  NSInvocation+encapsulate.m
//
//  Created by Oriol Blanc Gimeno on 07/05/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "NSInvocation+encapsulate.h"

@implementation NSInvocation (encapsulate)

+ (NSInvocation *)invocationForSelector:(SEL)selector target:(id)object
{
    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
	NSInvocation *callbackInvocation = [NSInvocation invocationWithMethodSignature:signature];
	[callbackInvocation setSelector:selector];
	[callbackInvocation setTarget:object];
	[callbackInvocation retainArguments];
	
	return callbackInvocation;
}

+ (NSInvocation *)invocationWithInvocation:(NSInvocation *)firstInvocation andInvocation:(NSInvocation *)secondInvocation parameters:(id)parameters customEncapsulation:(NSInvocation *)customInvokeEncapsulation
{
    return nil;
}

@end
