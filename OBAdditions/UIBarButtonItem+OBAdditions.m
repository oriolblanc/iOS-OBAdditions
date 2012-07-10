//
//  UIBarButtonItem+OBAdditions.m
//  Recetas
//
//  Created by Oriol Blanc Gimeno on 10/07/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIBarButtonItem+OBAdditions.h"
#import <objc/runtime.h>

static char UIBarButtonItemBlockKey;

@implementation UIBarButtonItem (OBAdditions)

- (id)initWithTitle:(NSString *)title 
              style:(UIBarButtonItemStyle)style 
        tapCallback:(UIBarButtonItemCallback)callback
{
    if ((self = [super initWithTitle:title style:style target:self action:@selector(buttonTapped)]))
    {
        objc_setAssociatedObject(self, &UIBarButtonItemBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return self;
}

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem tapCallback:(UIBarButtonItemCallback)callback
{
    if ((self = [super initWithBarButtonSystemItem:systemItem target:self action:@selector(buttonTapped)]))
    {
        objc_setAssociatedObject(self, &UIBarButtonItemBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image tapCallback:(UIBarButtonItemCallback)callback
{
    if ((self = [super initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(buttonTapped)]))
    {
        objc_setAssociatedObject(self, &UIBarButtonItemBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return self;
}

- (id)initWithCustomImage:(UIImage *)image tapCallback:(UIBarButtonItemCallback)callback
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    
    if ((self = [super initWithCustomView:button]))
    {
        objc_setAssociatedObject(self, &UIBarButtonItemBlockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)buttonTapped
{
    UIBarButtonItemCallback callback = (UIBarButtonItemCallback)objc_getAssociatedObject(self, &UIBarButtonItemBlockKey);
    
    if (callback != NULL)
    {
        callback(self);
    }
}

@end
