//
//  RottenGuavaTopMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVInTheatersMVC.h"
#import "RGVMovieVC.h"
#import "RottenTomatoesProvider.h"
#import "RGVInTheatersPaginator.h"


#define TOP_MOVIES_PAGE_SIZE 16

@interface RGVInTheatersMVC ()
@property (nonatomic) int total;
@end

@implementation RGVInTheatersMVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchFirstPage];
}

- (NMPaginator *)createPaginator
{
    return [[RGVInTheatersPaginator alloc] initWithPageSize:TOP_MOVIES_PAGE_SIZE delegate:self];
}

@end
