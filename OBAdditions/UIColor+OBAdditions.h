//
//  UIColor+OBAdditions.h
//
//  Created by Oriol Blanc on 12/20/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//

@interface UIColor (OBAdditions)

// Method to pass component values from 0 to 255 instead of from 0 to 1
+ (UIColor *)colorWithWholeRed:(CGFloat)wholeRed wholeGreen:(CGFloat)wholeGreen wholeBlue:(CGFloat)wholeBlue alpha:(CGFloat)alpha;

// Method to pass a string like @"AF04DB" representing a color in hexadecimal
+ (UIColor *)colorWithHexString:(NSString *)hexString;

// Generate a Random Color
+ (UIColor *)randomColor;

// Converts an HSL color value to RGB. Conversion formula
// Assumes h, s, and l are contained in the set [0, 1]
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

@end