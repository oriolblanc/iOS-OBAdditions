//
//  OBTheme.m
//
//  Created by Oriol Blanc Gimeno on 16/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

#import "OBTheme.h"

@implementation OBTheme

+ (UIImage *)imageNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) 
    {
        NSLog(@"error al cargar la imagen %@", imageName);
        [self passCheckpoint:nil];
    }
	return image;
}

+ (NSString *)localizedStringWithKey:(NSString *)key
{
	NSString *string = NSLocalizedString(key,@"");
        
    if ([string isEqualToString:key])
    {
        NSLog(@"Error at get translation for key = %@", key); 
        [self passCheckpoint:nil];
    }
    
    return string;
}

// you can override this method
+ (void)passCheckpoint:(NSString *)checkpoint
{

}

@end
