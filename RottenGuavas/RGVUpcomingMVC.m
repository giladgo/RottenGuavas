//
//  RottenGuavaUpcomingViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVUpcomingMVC.h"
#import "RottenTomatoesProvider.h"
#import "RGVUpcomingPaginator.h"

#define UPCOMING_PAGE_SIZE 16

@interface RGVUpcomingMVC ()
@end

@implementation RGVUpcomingMVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchFirstPage];
}

- (NMPaginator *)createPaginator
{
    return [[RGVUpcomingPaginator alloc] initWithPageSize:UPCOMING_PAGE_SIZE delegate:self];
}



@end
