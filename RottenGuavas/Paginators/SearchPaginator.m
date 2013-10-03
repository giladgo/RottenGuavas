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

- (NSArray *)resultsBlocking:(int*)total withPage:(int)page withPageSize:(int)pageSize
{
    return [RottenTomatoesProvider search:self.searchText withTotal:total withPage:page withPageSize:pageSize];
}

@end