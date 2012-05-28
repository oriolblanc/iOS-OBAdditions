//
//  UIColor+OBAdditions.m
//
//  Created by Oriol Blanc on 12/20/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//

#import "UIColor+OBAdditions.h"
#import <objc/runtime.h>

@implementation UIColor (OBAdditions)

+ (UIColor *)colorWithWholeRed:(CGFloat)wholeRed wholeGreen:(CGFloat)wholeGreen wholeBlue:(CGFloat)wholeBlue alpha:(CGFloat)alpha
{
    return [self colorWithRed:wholeRed/255.0 green:wholeGreen/255.0 blue:wholeBlue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    if (hexString.length != 6)
    {
        return nil;
    }
    
    NSMutableArray *colorFloatComponents = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++)
    {
        NSString *componentString = [hexString substringWithRange:NSMakeRange(i * 2, 2)];
        NSScanner *scanner = [NSScanner scannerWithString:componentString];
        NSUInteger componentIntValue;
        [scanner scanHexInt:&componentIntValue];
        
        [colorFloatComponents addObject:[NSNumber numberWithInt:componentIntValue]];
    }
    
    return [self colorWithWholeRed:[[colorFloatComponents objectAtIndex:0] intValue] wholeGreen:[[colorFloatComponents objectAtIndex:1] intValue] wholeBlue:[[colorFloatComponents objectAtIndex:2] intValue] alpha:1.0];
}

+ (void)load {
    Class c = (id)self;
    
    // Use class_getInstanceMethod for "normal" methods
    Method m1 = class_getClassMethod(c, @selector(description));
    Method m2 = class_getClassMethod(c, @selector(additionalDescription));
    
    // Swap the two methods.
    method_exchangeImplementations(m1, m2);
}

- (NSString *)additionalDescription
{
    NSString *description = [self additionalDescription];
    NSArray *items = [description componentsSeparatedByString:@" "];
    
    if (items != nil)
    {
//        items
    }
    
    return [NSString stringWithFormat:@"[UIColor]\n\t%@\n\tRed: %@\n\tGreen: %@\n\tBlue: %@\n\tAlpha: %@", [items objectAtIndex:0], [items objectAtIndex:1], [items objectAtIndex:2], [items objectAtIndex:3], [items objectAtIndex:4]];
}

@end
