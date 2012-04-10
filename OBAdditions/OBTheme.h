//
//  OBTheme.h
//
//  Created by Oriol Blanc Gimeno on 16/09/10.
//  Copyright 2011 Oriol Blanc All rights reserved.
//

@interface OBTheme : NSObject

+ (UIImage *)imageNamed:(NSString *)imageNamed;

+ (NSString *)localizedStringWithKey:(NSString *)key;

+ (void)passCheckpoint:(NSString *)checkpoint;

@end
