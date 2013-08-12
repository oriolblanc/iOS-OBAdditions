//
//  UIImage+OBAdditions.h
//
//  Created by Oriol Blanc Gimeno on 20/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

@interface UIImage (OBAdditions)

- (UIImage *)grayScaleImage;

/**
 Create a placeholder uiimage dynamically with color.
 
 @see http://ioscodesnippet.com/post/9247898208/creating-a-placeholder-uiimage-dynamically-with-color
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)fixOrientation;

@end
