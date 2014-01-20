//
//  UITextView+OBAdditions.m
//
//  Created by Oriol Blanc on 05/11/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UITextView+OBAdditions.h"

@implementation UITextView (OBAdditions)

- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)hor vertically:(CGFloat)ver
{
	return [self.text boundingRectWithSize:CGSizeMake(hor, ver)
                                   options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                attributes:@{NSFontAttributeName: self.font}
                                   context:nil].size;
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

@end
