//
//  MoviesPaginator.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "MoviesPaginator.h"

@implementation MoviesPaginator

- (NSArray *)resultsBlocking:(int*)total withPage:(int)page withPageSize:(int)pageSize
{
    return nil;
}

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    // Blocking for now, empty for now
    
    __block int total;
    
    dispatch_queue_t dq = dispatch_queue_create("top movies DQ", NULL);
    
    dispatch_async(dq, ^{
        NSArray *arr = [self resultsBlocking:&total withPage:page withPageSize:pageSize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self receivedResults:arr total:total];
        });
    });
}

@end
