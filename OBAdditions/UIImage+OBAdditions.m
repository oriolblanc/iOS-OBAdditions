//
//  UIImage+OBAdditions.m
//
//  Created by Oriol Blanc Gimeno on 20/04/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "UIImage+OBAdditions.h"
#import <objc/runtime.h> 

#ifndef ilegalStepWarningWithFormat
    #define ilegalStepWarningWithFormat(__FORMAT__, ...)
#endif

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
    
    NSString *extension = [splitedImageName objectAtIndex:splitedImageName.count - 1];
    
    NSString *fileName = [imageName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",extension] withString:@""];
    
    if (splitedImageName.count < 2)
    {
        ilegalStepWarningWithFormat(@"Ilegal image name");
        return nil;
    }
    
    UIImage* image = nil;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f)
    {
        image = [self additionalImageNamed:[NSString stringWithFormat:@"%@-568h@2x.%@",fileName, extension]];
    }
    else
    {
        image = [self additionalImageNamed:[NSString stringWithFormat:@"%@-480h@2x.%@",fileName, extension]];
    }

    
    if (image == nil)
    {
        image = [self additionalImageNamed:imageName];
    }
    
    if (image == nil)
    {
        NSLog(@"error al cargar la imagen '%@'", imageName);
        ilegalStepWarningWithFormat(@"[IMAGE_NOTFOUND] %@", imageName);
    }
	return image;
}

@end
