//
//  CLLocationManager+OBAdditions.h
//
//  Created by Oriol Blanc on 12/10/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef void (^OBLocationManagerUpdateCallback)(CLLocation *newLocation, CLLocation *oldLocation);
typedef void (^OBLocationManagerErrorCallback)(NSError *error);

@interface CLLocationManager (OBAdditions)

+ (CLLocationManager *)locationManagerWithUpdateBlock:(OBLocationManagerUpdateCallback)updateBlock errorBlock:(OBLocationManagerErrorCallback)errorBlock;

@end
