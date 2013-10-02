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

#define TOP_MOVIES_PAGE_SIZE 16

@interface RottenGuavaTopMoviesViewController ()
@property (nonatomic) int total;
@end

@implementation RottenGuavaTopMoviesViewController

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.movies.count - (TOP_MOVIES_PAGE_SIZE/2) && self.total > self.movies.count) {
        [self loadMoviesFromBlock:^NSArray *{
            return [RottenTomatoesProvider getInTheaters:NULL withPage:(self.movies.count / TOP_MOVIES_PAGE_SIZE) + 1 withPageSize:TOP_MOVIES_PAGE_SIZE];
        } withAnimation:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadMoviesFromBlock:^NSArray *{
        int total;
        NSArray *arr = [RottenTomatoesProvider getInTheaters:&total withPage:1 withPageSize:TOP_MOVIES_PAGE_SIZE];
        self.total = total;
        return arr;
    } withAnimation:YES];
    
}
@end
