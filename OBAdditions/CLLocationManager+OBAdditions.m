//
//  CLLocationManager+OBAdditions.m
//
//  Created by Oriol Blanc on 12/10/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "CLLocationManager+OBAdditions.h"
#import <objc/runtime.h>

@interface OBLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, copy) OBLocationManagerUpdateCallback updateBlock;
@property (nonatomic, copy) OBLocationManagerErrorCallback errorBlock;

- (id)initWithUpdateBlock:(OBLocationManagerUpdateCallback)updateBlock errorBlock:(OBLocationManagerErrorCallback)errorBlock;

@end

@implementation OBLocationManager
@synthesize updateBlock = _updateBlock;
@synthesize errorBlock = _errorBlock;

- (id)initWithUpdateBlock:(OBLocationManagerUpdateCallback)updateBlock errorBlock:(OBLocationManagerErrorCallback)errorBlock
{
	self = [super init];
	if (self) {
		self.updateBlock = updateBlock;
		self.errorBlock = errorBlock;
	}
    
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	if (self.updateBlock != NULL)
    {
		self.updateBlock(newLocation, oldLocation);
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if (self.errorBlock != NULL)
    {
		self.errorBlock(error);
	}
}

- (void)dealloc
{
    if (_updateBlock != NULL)
    {
        [_updateBlock release];
    }
    
    if (_errorBlock != NULL)
    {
        [_errorBlock release];
    }
    
    [super dealloc];
}

@end

@implementation CLLocationManager (OBAdditions)

+ (CLLocationManager *)locationManagerWithUpdateBlock:(OBLocationManagerUpdateCallback)updateBlock errorBlock:(OBLocationManagerErrorCallback)errorBlock
{
    CLLocationManager *locationManager = [[[self alloc] init] autorelease];
    
    OBLocationManager *manager = [[[OBLocationManager alloc] initWithUpdateBlock:updateBlock errorBlock:errorBlock] autorelease];
    
    objc_setAssociatedObject(locationManager, @"CLLocationManagerBlocks", manager, OBJC_ASSOCIATION_RETAIN);
    
	return locationManager;
}

@end