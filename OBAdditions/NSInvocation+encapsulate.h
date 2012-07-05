//
//  NSInvocation+encapsulate.h
//  Gossip
//
//  Created by Oriol Blanc Gimeno on 07/05/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (encapsulate)

+ (NSInvocation *)invocationForSelector:(SEL)selector target:(id)object;

+ (NSInvocation *)invocationWithInvocation:(NSInvocation *)firstInvocation
                             andInvocation:(NSInvocation *)secondInvocation
                                parameters:(id)parameters 
                       customEncapsulation:(NSInvocation *)customInvokeEncapsulation;

@end
