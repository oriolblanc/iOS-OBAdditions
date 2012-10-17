//
//  OBTheme.m
//
//  Created by Oriol Blanc Gimeno on 16/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

#import "OBTheme.h"

#ifndef ilegalStepWarningWithFormat
    #define ilegalStepWarningWithFormat(__FORMAT__, ...)
#endif

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
    return [UIImage imageNamed:imageName];
}

+ (NSString *)localizedStringWithKey:(NSString *)key
{
	NSString *string = NSLocalizedString(key,@"");
        
    if ([string isEqualToString:key])
    {
        NSLog(@"Error at get translation for key = %@", key); 
        ilegalStepWarningWithFormat(@"[TRANSLATION_NOTFOUND] key %@", key);
    }
    
    return string;
}

// you can override this method
+ (void)ilegalStepWarningWithString:(NSString *)string
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:OBThemeIlegalStepWarning
     object:string];
}

@end
