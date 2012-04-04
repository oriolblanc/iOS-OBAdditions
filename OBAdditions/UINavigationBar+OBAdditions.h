//
//  UINavigationBar+OBAdditions.h
//
//  Created by Oriol Blanc on 28/09/11.
//  Copyright 2011 Oriol Blanc. All rights reserved.
//

@interface UINavigationBar (OBAdditions)

- (void)customizeBackgroundImage:(UIImage *)image tintColor:(UIColor *)tintColor;
- (void)setTitleTextAttributes;

- (void)additionalInsertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)additionalSendSubviewToBack:(UIView *)view;

- (void)setProgressBarPercentage:(float)percentage;
- (void)hideProgressBar;

@end 