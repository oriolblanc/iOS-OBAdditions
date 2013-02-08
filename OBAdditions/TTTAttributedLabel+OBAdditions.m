//
//  TTTAttributedLabel+OBAdditions.m
//
//  Created by Oriol Blanc on 1/12/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "TTTAttributedLabel+OBAdditions.h"

#import <QuartzCore/QuartzCore.h>

@implementation TTTAttributedLabel (OBAdditions)

#pragma mark - Setting bold

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges boldRangesColor:(UIColor *)color fontSize:(CGFloat)fontSize
{
    __weak typeof(self) weakSelf = self;
    
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        UIFont *boldFont = [UIFont boldSystemFontOfSize:weakSelf.font.pointSize];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldFont.fontName, fontSize, NULL);
        CGColorRef boldRangeColor = color.CGColor;
        
        if (font)
        {
            for (NSValue *rangeValue in ranges)
            {
                NSRange range = [rangeValue rangeValue]; 
                if (range.location != NSNotFound)
                {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:range];
                    
                    if (![color isEqual:weakSelf.textColor])
                    {
                        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)boldRangeColor range:range];
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

#pragma mark - Changing color

- (void)setText:(NSString *)text colorRanges:(NSArray *)ranges color:(UIColor *)color
{
    __weak typeof(self) weakSelf = self;
    
    [self setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)weakSelf.font.fontName, weakSelf.font.pointSize, NULL);
        CGColorRef rangeColor = color.CGColor;
        
        for (NSValue *rangeValue in ranges)
        {
            NSRange range = [rangeValue rangeValue];
            if (range.location != NSNotFound)
            {
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:range];
                
                if (![color isEqual:weakSelf.textColor])
                {
                    [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)rangeColor range:range];
                }
            }
        }
        CFRelease(font);
        
        return mutableAttributedString;
    }];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)setText:(NSString *)text colorRange:(NSRange)range color:(UIColor *)color
{
    [self setText:text colorRanges:[NSArray arrayWithObject:[NSValue valueWithRange:range]] color:color];   
}

@end
