//
//  UIImage+OBAdditions.m
//
//  Created by Oriol Blanc Gimeno on 20/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIImage+OBAdditions.h"
#import <objc/runtime.h> 

@implementation UIImage (OBAdditions)

+ (void)load {
    Class c = (id)self;
    
    // Use class_getInstanceMethod for "normal" methods
    Method m1 = class_getClassMethod(c, @selector(imageNamed:));
    Method m2 = class_getClassMethod(c, @selector(additionalImageNamed:));
    
    // Swap the two methods.
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)additionalImageNamed:(NSString *)imageName
{
    NSArray *splitedImageName = [imageName componentsSeparatedByString:@"."];
    if (splitedImageName.count != 2)
    {
        // ilegal
        return nil;
    }
    
    UIImage* image = nil;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f)
    {
        image = [self additionalImageNamed:[NSString stringWithFormat:@"%@-568h@2x.%@",
                                              [splitedImageName objectAtIndex:0],
                                              [splitedImageName objectAtIndex:1]]];
    }
    
    if (image == nil)
    {
        image = [self additionalImageNamed:imageName];
    }
    
    if (image == nil)
    {
        NSLog(@"error al cargar la imagen '%@'", imageName);
        [OBTheme ilegalStepWarningWithString:[NSString stringWithFormat:@"[IMAGE_NOTFOUND] %@", imageName]];
    }
	return image;
}

@end
