//
//  SearchPaginator.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/3/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "SearchPaginator.h"
#import "RottenTomatoesProvider.h"

@implementation SearchPaginator

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    // Blocking for now, empty for now
    int total;
    NSArray *arr = [RottenTomatoesProvider search:@"" withTotal:&total withPage:page withPageSize:pageSize];
    [self receivedResults:arr total:total];
}

@end
