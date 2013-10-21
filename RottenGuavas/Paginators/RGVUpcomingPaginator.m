//
//  UpcomingMoviesPaginator.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVUpcomingPaginator.h"
#import "RottenTomatoesProvider.h"


@implementation RGVUpcomingPaginator


- (NSArray *)resultsBlocking:(int*)total withPage:(int)page withPageSize:(int)pageSize
{
    return [RottenTomatoesProvider getUpcoming:total withPage:page withPageSize:pageSize fromCountryCode:self.countryCode];
}


@end
