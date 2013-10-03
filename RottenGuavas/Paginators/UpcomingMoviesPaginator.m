//
//  UpcomingMoviesPaginator.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "UpcomingMoviesPaginator.h"
#import "RottenTomatoesProvider.h"


@implementation UpcomingMoviesPaginator

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    
    __block int total;
    
    dispatch_queue_t dq = dispatch_queue_create("top movies DQ", NULL);
    
    dispatch_async(dq, ^{
        NSArray *arr = [RottenTomatoesProvider getUpcoming:&total withPage:page withPageSize:pageSize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self receivedResults:arr total:total];
        });
    });

}

@end
