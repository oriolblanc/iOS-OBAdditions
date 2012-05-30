//
//  MKMapView+OBAdditions.m
//
//  Created by Oriol Blanc on 12/03/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import "MKMapView+OBAdditions.h"

@implementation MKMapView (OBAdditions)

- (BOOL)isRegionValid:(MKCoordinateRegion)region
{
    BOOL isRegionValid = region.center.latitude < 90.0f && region.center.latitude > -90.0f && region.center.longitude > -180.0f && region.center.longitude < 180.0f;
    
    return isRegionValid;
}

- (void)setMapCenter
{
    return [self setMapCenterAnimated:YES];
}

- (void)setMapCenterAnimated:(BOOL)animated
{
    if ([self.annotations count] == 0)
    {
        return;   
    } 
    
    CLLocationCoordinate2D bottomRightCoord; 
    bottomRightCoord.latitude = -90; 
    bottomRightCoord.longitude = 180; 
    
    CLLocationCoordinate2D topLeftCoord; 
    topLeftCoord.latitude = 90; 
    topLeftCoord.longitude = -180; 
    
    NSMutableArray *locationsToConsider = [NSMutableArray array];
    
    for (id <MKAnnotation>annotation in self.annotations)
    {
        if ([self isValidCoordinate:annotation.coordinate])
        {
            CLLocation *location = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
            [locationsToConsider addObject:location];
            [location release];
        }
    }
    
    if (self.userLocation && [self isValidCoordinate:self.userLocation.coordinate])
    {
        [locationsToConsider addObject:self.userLocation];                                      
    }
    
    for (CLLocation *location in locationsToConsider)
    { 
        bottomRightCoord.longitude = fmin(bottomRightCoord.longitude, location.coordinate.longitude); 
        bottomRightCoord.latitude = fmax(bottomRightCoord.latitude, location.coordinate.latitude); 
        topLeftCoord.longitude = fmax(topLeftCoord.longitude, location.coordinate.longitude); 
        topLeftCoord.latitude = fmin(topLeftCoord.latitude, location.coordinate.latitude); 
    } 
    
    CLLocation *topLeftLocation = [[[CLLocation alloc] initWithLatitude:bottomRightCoord.latitude longitude:bottomRightCoord.longitude] autorelease];
    CLLocation *bottomRightLocation = [[[CLLocation alloc] initWithLatitude:topLeftCoord.latitude longitude:topLeftCoord.longitude] autorelease];
    
    CLLocationDistance meters = [bottomRightLocation distanceFromLocation:topLeftLocation];
    
    MKCoordinateRegion region;
    region.center.latitude = (topLeftCoord.latitude + bottomRightCoord.latitude) / 2.0;
    region.center.longitude = (topLeftCoord.longitude + bottomRightCoord.longitude) / 2.0;
    NSUInteger paddingMeters = 20;
    region.span.latitudeDelta = (meters + paddingMeters) / 111319.5;
    region.span.longitudeDelta = 0.0;
    
    if ([self isRegionValid:region])
    {
        [self setRegion:[self regionThatFits:region] animated:animated];
    }
    else
    {
        // Too bad. Let's center in the user
        if (self.userLocation)
        {
            MKCoordinateRegion userLocationRegion = MKCoordinateRegionMakeWithDistance(self.userLocation.coordinate, 100, 100);
            if ([self isRegionValid:userLocationRegion])
            {
                [self setRegion:userLocationRegion animated:animated];
            }
        }
        else
        {
            NSLog(@"Invalid region to center the map properly");
        }
    }
}

- (CLLocationDistance)distanceFromUserLocationToCoordinate:(CLLocationCoordinate2D)coordinate
{
    CLLocation *pinLocation = [[CLLocation alloc ] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLLocationDistance distance = [pinLocation distanceFromLocation:self.userLocation.location];
    [pinLocation release];
    
    return distance;
}

- (BOOL)isCoordinateInsideMap:(CLLocationCoordinate2D)coordinate 
{
    CLLocationCoordinate2D topLeftCoord = [self getTopLeftCoordinate];
    CLLocationCoordinate2D bottomRightCoord = [self getBottomRightCoordinate];
    
    BOOL isInsideLongitude = coordinate.longitude >= topLeftCoord.longitude && coordinate.longitude <= bottomRightCoord.longitude;
    BOOL isInsideLatitude = coordinate.latitude <= topLeftCoord.latitude && coordinate.latitude >= bottomRightCoord.latitude;
    
    return isInsideLongitude && isInsideLatitude;
}

#pragma mark - private 

- (CLLocationCoordinate2D)getTopLeftCoordinate
{
    MKCoordinateRegion region = self.region;
    
    CLLocationCoordinate2D topLeftCoord; 
    topLeftCoord.longitude = region.center.longitude - region.span.longitudeDelta / 2.0;  
    topLeftCoord.latitude = region.center.latitude + region.span.latitudeDelta / 2.0; 
    
    return topLeftCoord;
}

- (CLLocationCoordinate2D)getBottomRightCoordinate
{
    MKCoordinateRegion region = self.region;
    
    CLLocationCoordinate2D bottomRightCoord; 
    bottomRightCoord.longitude = region.center.longitude + region.span.longitudeDelta / 2.0; 
    bottomRightCoord.latitude = region.center.latitude - region.span.latitudeDelta / 2.0; 
    
    return bottomRightCoord;
}

- (BOOL)isValidCoordinate:(CLLocationCoordinate2D)coordinate
{
    return coordinate.longitude != 0 && coordinate.latitude != 0;
}

@end