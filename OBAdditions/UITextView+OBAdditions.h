//
//  UITextView+OBAdditions.h
//
//  Created by Oriol Blanc on 05/11/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (OBAdditions)

- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)hor
                                    vertically:(CGFloat)ver;
- (CGSize)suggestedSizeConstrainedHorizontally:(CGFloat)max;
- (CGSize)suggestedSizeConstrainedVertically:(CGFloat)max;
- (CGSize)suggestedSize;

@end
