//
//  UILabel+OBAdditions.m
//
//  Created by Oriol Blanc on 22/12/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//

#import "UILabel+OBAdditions.h"

@implementation UILabel (OBAdditions)

- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)hor vertically:(CGFloat)ver
{
	return [self.text sizeWithFont:self.font 
                 constrainedToSize:CGSizeMake(hor, ver) 
                     lineBreakMode:self.lineBreakMode];
}


- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)max
{
	return [self suggestedSizeConstrainedHorizontally:max vertically:FLT_MAX];
}

- (CGSize)suggestedSizeConstrainedVertically:(CGFloat)max
{
	return [self suggestedSizeConstrainedHorizontally:FLT_MAX vertically:max];
}

- (CGSize)suggestedSize
{
	return [self suggestedSizeConstrainedHorizontally:FLT_MAX vertically:FLT_MAX];
}

- (void)setVerticalTextAligment:(UITextVerticalAlignment)verticalAlignment
{
    CGSize suggestedSize = [self suggestedSizeConstrainedHorizontally:self.frame.size.width];
    CGRect textRect = self.frame;
    
    switch (verticalAlignment) {
        case UITextVerticalAlignmentTop:
        {
            textRect.size.height = suggestedSize.height;
            break;
        }
        case UITextVerticalAlignmentBottom:
        {
            textRect.origin.y = self.frame.size.height - suggestedSize.height;
            textRect.size.height = suggestedSize.height;
            break;
        }
        case UITextVerticalAlignmentMiddle:
        default:
        {

        }
    }
    
    self.frame = textRect;
}

@end
