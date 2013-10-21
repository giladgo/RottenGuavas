//
//  UpcomingMoviesPaginator.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVMoviesPaginator.h"


@interface RGVUpcomingPaginator : RGVMoviesPaginator <RGVCountryPaginator>

@property (nonatomic, strong) NSString *countryCode;

@end
