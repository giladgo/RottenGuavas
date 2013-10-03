//
//  RottenGuavaTopMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaTopMoviesViewController.h"
#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"
#import "TopMoviesPaginator.h"

#define TOP_MOVIES_PAGE_SIZE 16

@interface RottenGuavaTopMoviesViewController ()
@property (nonatomic) int total;
@end

@implementation RottenGuavaTopMoviesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.paginator = [[TopMoviesPaginator alloc] initWithPageSize:TOP_MOVIES_PAGE_SIZE delegate:self];
    [self fetchFirstPage];
}


@end
