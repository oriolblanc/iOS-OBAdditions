//
//  MKMapView+OBAdditions.h
//
//  Created by Oriol Blanc on 12/03/12.
//  Copyright (c) 2012 Oriol Blanc. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (OBAdditions)

- (BOOL)isRegionValid:(MKCoordinateRegion)region;
- (void)setMapCenter;

- (BOOL)isCoordinateInsideMap:(CLLocationCoordinate2D)coordinate;

@end
