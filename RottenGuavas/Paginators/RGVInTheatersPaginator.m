//
//  TopMoviesPaginator.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVInTheatersPaginator.h"
#import "RottenTomatoesProvider.h"
#import "dispatch/queue.h"

@implementation RGVInTheatersPaginator


- (NSArray *)resultsBlocking:(int*)total withPage:(int)page withPageSize:(int)pageSize
{
    return [RottenTomatoesProvider getInTheaters:total withPage:page withPageSize:pageSize fromCountryCode:self.countryCode];
}

@end
