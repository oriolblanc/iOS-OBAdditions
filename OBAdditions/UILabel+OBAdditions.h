//
//  UILabel+OBAdditions.h
//
//  Created by Oriol Blanc on 22/12/11.
//  Copyright (c) 2011 Oriol Blanc. All rights reserved.
//

@interface UILabel (OBAdditions)

- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)hor 
                                    vertically:(CGFloat)ver;
- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)max;
- (CGSize)suggestedSizeConstrainedVertically:(CGFloat)max;
- (CGSize)suggestedSize;

@end
