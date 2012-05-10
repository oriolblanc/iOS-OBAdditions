//
//  UIImageView+OBAdditions.m
//  Fever
//
//  Created by Oriol Blanc Gimeno on 10/05/12.
//  Copyright (c) 2012 Fever, Inc. All rights reserved.
//

#import "UIImageView+OBAdditions.h"

@implementation UIImageView (OBAdditions)

- (UIColor *)colorAtPoint:(CGPoint)point
{
    UIColor* color = nil;
    
    CGImageRef cgImage = [self.image CGImage];
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    NSUInteger x = (NSUInteger)floor(point.x);
    NSUInteger y = height - (NSUInteger)floor(point.y);
    
    if ((x < width) && (y < height))
    {
        CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
        CFDataRef bitmapData = CGDataProviderCopyData(provider);
        const UInt8* data = CFDataGetBytePtr(bitmapData);
        size_t offset = ((width * y) + x) * 4;
        UInt8 red = data[offset];
        UInt8 blue = data[offset+1];
        UInt8 green = data[offset+2];
        UInt8 alpha = data[offset+3];
        CFRelease(bitmapData);
        color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
    }
    
    return color;
}

@end
