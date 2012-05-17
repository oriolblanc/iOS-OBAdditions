//
//  TTTAttributedLabel+OBAdditions.h
//
//  Created by Oriol Blanc on 1/12/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "TTTAttributedLabel.h"

@interface TTTAttributedLabel (OBAdditions)

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges boldRangesColor:(UIColor *)color fontSize:(CGFloat)fontSize;
- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges boldRangesColor:(UIColor *)color;

- (void)setText:(NSString *)text boldRange:(NSRange)range boldRangeColor:(UIColor *)color fontSize:(CGFloat)fontSize;
- (void)setText:(NSString *)text boldRange:(NSRange)range boldRangeColor:(UIColor *)color;

- (void)setText:(NSString *)text boldRanges:(NSArray *)ranges;
- (void)setText:(NSString *)text boldRange:(NSRange)range;

@end
