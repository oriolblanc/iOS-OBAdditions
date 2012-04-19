//
//  OBTheme.m
//
//  Created by Oriol Blanc Gimeno on 16/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

#import "OBTheme.h"

@implementation OBTheme

+ (UIColor *)colorForKey:(NSString *)key
{
    if ([key isEqualToString:kColorKeySubtitleShadowColor])
    {
        return [UIColor colorWithWholeRed:0.0 wholeGreen:0.0 wholeBlue:0.0 alpha:.5];
	}
    else
    {
        return [UIColor blackColor];
    }
}

+ (UIImage *)imageNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) 
    {
        NSLog(@"error al cargar la imagen %@", imageName);
        [self ilegalStepWarningWithString:[NSString stringWithFormat:@"[IMAGE_NOTFOUND] %@", imageName]];
    }
	return image;
}

+ (NSString *)localizedStringWithKey:(NSString *)key
{
	NSString *string = NSLocalizedString(key,@"");
        
    if ([string isEqualToString:key])
    {
        NSLog(@"Error at get translation for key = %@", key); 
        [self ilegalStepWarningWithString:[NSString stringWithFormat:@"[TRANSLATION_NOTFOUND] key %@", key]];
    }
    
    return string;
}

// you can override this method
+ (void)ilegalStepWarningWithString:(NSString *)string
{

}

@end
