//
//  RottenGuavaLocationMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/6/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaLocationMoviesViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RottenGuavaLocationMoviesViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geoCoder;
@end

@implementation RottenGuavaLocationMoviesViewController

- (void) fetchFirstPage
{
    if (![CLLocationManager locationServicesEnabled]) {
        // Just get US
        [super fetchFirstPage];
    }
    else {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        [self.locationManager startUpdatingLocation];
    }
}

- (CLGeocoder *)geoCoder
{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"location manager callback");    
    if (![self.paginator respondsToSelector:@selector(countryCode)]) {
        NSLog(@"whoops");
        [super fetchFirstPage];
        return;
    }
    
    if ([self.paginator performSelector:@selector(countryCode)]) {
        return;
    }
    
    for (CLLocation* newLocation in locations)
    {
        [self.geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                // When reverse-geocoding we should get only one element
                CLPlacemark* placeMark = [placemarks firstObject];
                [self.paginator performSelector:@selector(setCountryCode:) withObject:placeMark.ISOcountryCode];
                NSLog(@"c = %@", placeMark.country);
                self.navItem.title = [NSString stringWithFormat:@"%@ - %@", self.navItem.title, placeMark.country];
            }
            
            [super fetchFirstPage];
        }];
    }
}

@end
