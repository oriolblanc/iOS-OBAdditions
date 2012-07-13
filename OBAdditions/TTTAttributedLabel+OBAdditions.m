//
//  TTTAttributedLabel+OBAdditions.m
//
//  Created by Oriol Blanc on 1/12/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "TTTAttributedLabel+OBAdditions.h"

#import <QuartzCore/QuartzCore.h>

@implementation TTTAttributedLabel (OBAdditions)

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges boldRangesColor:(UIColor *)color fontSize:(CGFloat)fontSize
{
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        UIFont *boldFont = [UIFont boldSystemFontOfSize:self.font.pointSize];
        CTFontRef font = CTFontCreateWithName((CFStringRef)boldFont.fontName, fontSize, NULL);
        CGColorRef boldRangeColor = color.CGColor;
        
        if (font)
        {
            for (NSValue *rangeValue in ranges)
            {
                NSRange range = [rangeValue rangeValue]; 
                if (range.location != NSNotFound)
                {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)font range:range];
                    
                    if (![color isEqual:self.textColor])
                    {
                        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)boldRangeColor range:range];
                    }
                }
            }
            
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges boldRangesColor:(UIColor *)color 
{
    [self setText:text boldRanges:ranges boldRangesColor:color fontSize:self.font.pointSize];
}

- (void)setText:(NSString *)text boldRange:(NSRange)range boldRangeColor:(UIColor *)color fontSize:(CGFloat)fontSize
{
    [self setText:text boldRanges:[NSArray arrayWithObject:[NSValue valueWithRange:range]] boldRangesColor:color fontSize:fontSize];
}

- (void)setText:(NSString *)text boldRange:(NSRange)range boldRangeColor:(UIColor *)color
{
    [self setText:text boldRanges:[NSArray arrayWithObject:[NSValue valueWithRange:range]] boldRangesColor:color fontSize:self.font.pointSize];
}

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges
{
    [self setText:text boldRanges:ranges boldRangesColor:self.textColor];
}

- (void)setText:(NSString *)text boldRange:(NSRange)range
{
    [self setText:text boldRanges:[NSArray arrayWithObject:[NSValue valueWithRange:range]]];
}

- (void)setText:(NSString *)text colorRange:(NSRange)range color:(UIColor *)color
{
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        CGColorRef rangeColor = color.CGColor;
        
        if (range.location != NSNotFound)
        {
            CTFontRef font = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(id)font range:range];
            
            if (![color isEqual:self.textColor])
            {
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)rangeColor range:range];
            }
            
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

@end
