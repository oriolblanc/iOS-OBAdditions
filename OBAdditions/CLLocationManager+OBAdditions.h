//
//  CLLocationManager+OBAdditions.h
//
//  Created by Oriol Blanc on 12/10/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocationManager (OBAdditions)

- (void)updateLocationWithBlock:(void (^)(CLLocation *newLocation, CLLocation *oldLocation))updateBlock errorBlock:(void (^)(NSError *error))errorBlock;

@end
