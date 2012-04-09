//
//  UIButton+OBAdditions.h
//
//  Created by Oriol Blanc on 02/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

@interface UIButton (OBAdditions)

- (void)setTitle:(NSString *)title andSubtitle:(NSString *)subtitle forState:(UIControlState)state;

- (UILabel *)additionalTitleLabel;
- (UILabel *)additionalSubtitleLabel;

@end
