//
//  RottenGuavaUpcomingViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaUpcomingViewController.h"
#import "RottenTomatoesProvider.h"
#import "UpcomingMoviesPaginator.h"

#define UPCOMING_PAGE_SIZE 16

@interface RottenGuavaUpcomingViewController ()
@end

@implementation RottenGuavaUpcomingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.paginator = [[UpcomingMoviesPaginator alloc] initWithPageSize:UPCOMING_PAGE_SIZE delegate:self];
    [self fetchFirstPage];
}



@end
