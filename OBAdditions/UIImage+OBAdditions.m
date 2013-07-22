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

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)grayScaleImage
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width * self.scale, self.size.height * self.scale, 8, 0, colorSpace, kCGImageAlphaNone);
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // Create bitmap image info from pixel data in current context
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    // release the colorspace and graphics context
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    // make a new alpha-only graphics context
    context = CGBitmapContextCreate(nil, self.size.width * self.scale, self.size.height * self.scale, 8, 0, nil, kCGImageAlphaOnly);
    // draw image into context with no colorspace
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // create alpha bitmap mask from current context
    CGImageRef mask = CGBitmapContextCreateImage(context);
    // release graphics context
    CGContextRelease(context);
    // make UIImage from grayscale image with alpha mask
    CGImageRef cgImage = CGImageCreateWithMask(grayImage, mask);
    UIImage *grayScaleImage = [UIImage imageWithCGImage:cgImage scale:self.scale orientation:self.imageOrientation];
    // release the CG images
    CGImageRelease(cgImage);
    CGImageRelease(grayImage);
    CGImageRelease(mask);
    // return the new grayscale image
    return grayScaleImage;
}

@end
