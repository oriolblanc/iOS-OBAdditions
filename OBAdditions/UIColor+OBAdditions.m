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
        unsigned int componentIntValue;
        [scanner scanHexInt:&componentIntValue];
        
        [colorFloatComponents addObject:[NSNumber numberWithUnsignedInteger:componentIntValue]];
    }
    
    return [self colorWithWholeRed:[[colorFloatComponents objectAtIndex:0] intValue] wholeGreen:[[colorFloatComponents objectAtIndex:1] intValue] wholeBlue:[[colorFloatComponents objectAtIndex:2] intValue] alpha:1.0];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
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

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    CGFloat r,g,b;
    HSL_TO_RGB(hue, saturation, lightness, &r, &g, &b);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

- (BOOL)isEqualToColor:(UIColor *)otherColor
{
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            return [UIColor colorWithCGColor:CGColorCreate(colorSpaceRGB, components)];
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];
}

/**
 * HSL to RGB converter.
 * Adapted from: https://github.com/alessani/ColorConverter
 */
static void HSL_TO_RGB (CGFloat h, CGFloat s, CGFloat l, CGFloat *outR, CGFloat *outG, CGFloat *outB)
{
	CGFloat			temp1,
    temp2;
	CGFloat			temp[3];
	int				i;
    
	// Check for saturation. If there isn't any just return the luminance value for each, which results in gray.
	if(s == 0.0) {
		if(outR)
			*outR = l;
		if(outG)
			*outG = l;
		if(outB)
			*outB = l;
		return;
	}
    
	// Test for luminance and compute temporary values based on luminance and saturation
	if(l < 0.5)
		temp2 = l * (1.0 + s);
	else
		temp2 = l + s - l * s;
    temp1 = 2.0 * l - temp2;
    
	// Compute intermediate values based on hue
	temp[0] = h + 1.0 / 3.0;
	temp[1] = h;
	temp[2] = h - 1.0 / 3.0;
    
	for(i = 0; i < 3; ++i) {
        
		// Adjust the range
		if(temp[i] < 0.0)
			temp[i] += 1.0;
		if(temp[i] > 1.0)
			temp[i] -= 1.0;
        
        
		if(6.0 * temp[i] < 1.0)
			temp[i] = temp1 + (temp2 - temp1) * 6.0 * temp[i];
		else {
			if(2.0 * temp[i] < 1.0)
				temp[i] = temp2;
			else {
				if(3.0 * temp[i] < 2.0)
					temp[i] = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - temp[i]) * 6.0;
				else
					temp[i] = temp1;
			}
		}
	}
    
	// Assign temporary values to R, G, B
	if(outR)
		*outR = temp[0];
	if(outG)
		*outG = temp[1];
	if(outB)
		*outB = temp[2];
}

@end
