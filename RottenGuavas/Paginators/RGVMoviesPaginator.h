//
//  MoviesPaginator.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "NMPaginator.h"

@protocol RGVCountryPaginator <NSObject>

@property (nonatomic, strong) NSString *countryCode;

@end

@interface RGVMoviesPaginator : NMPaginator
- (NSArray *)resultsBlocking:(int*)total withPage:(int)page withPageSize:(int)pageSize;
@end
