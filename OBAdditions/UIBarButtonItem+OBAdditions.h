//
//  UIBarButtonItem+OBAdditions.h
//  Recetas
//
//  Created by Oriol Blanc Gimeno on 10/07/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIBarButtonItem;
typedef void (^UIBarButtonItemCallback)(UIBarButtonItem *button);

@interface UIBarButtonItem (OBAdditions)

+ (id)negativeBarButtonItemSpacerWithWidth:(CGFloat)width;

- (id)initWithTitle:(NSString *)title 
              style:(UIBarButtonItemStyle)style 
        tapCallback:(UIBarButtonItemCallback)callback;

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem 
                      tapCallback:(UIBarButtonItemCallback)callback;

- (id)initWithImage:(UIImage *)image
        tapCallback:(UIBarButtonItemCallback)callback;

- (id)initWithCustomImage:(UIImage *)image 
              tapCallback:(UIBarButtonItemCallback)callback;

- (id)initWithCustomImage:(UIImage *)image
         highlightedImage:(UIImage *)highlightedImage;

- (id)initWithCustomImage:(UIImage *)image
         highlightedImage:(UIImage *)highlightedImage
              tapCallback:(UIBarButtonItemCallback)callback;

@end
