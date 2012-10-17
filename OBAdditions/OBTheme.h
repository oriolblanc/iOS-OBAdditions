//
//  OBTheme.h
//
//  Created by Oriol Blanc Gimeno on 16/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

static NSString * const kColorKeySubtitleShadowColor = @"kColorKeySubtitleShadowColor";

@interface OBTheme : NSObject

+ (UIColor *)colorForKey:(NSString *)key;

+ (UIImage *)imageNamed:(NSString *)imageNamed;
+ (NSString *)localizedStringWithKey:(NSString *)key;

+ (void)ilegalStepWarningWithString:(NSString *)string;

@end
