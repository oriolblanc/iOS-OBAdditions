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
    UIImage *image;
    UIColor *color = [UIColor grayColor];
    
    UIGraphicsBeginImageContext([self size]);

    CGRect rect = CGRectZero;
    rect.size = [self size];
    
    // Composite tint color at its own opacity.
    [color set];
    UIRectFill(rect);
    
    // Mask tint color-swatch to this image's opaque mask.
    // We want behaviour like NSCompositeDestinationIn on Mac OS X.
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    // Finally, composite this image over the tinted mask at desired opacity.
    [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:0.5];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
