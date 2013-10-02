//
//  RottenGuavaUpcomingViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaUpcomingViewController.h"
#import "RottenTomatoesProvider.h"

#define UPCOMING_PAGE_SIZE 16

@interface RottenGuavaUpcomingViewController ()
@property (nonatomic) int total;
@end

@implementation RottenGuavaUpcomingViewController


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.movies.count - (UPCOMING_PAGE_SIZE/2) && (self.total > self.movies.count)) {
        [self loadMoviesFromBlock:^NSArray *{
            return [RottenTomatoesProvider getUpcoming:NULL withPage:(self.movies.count / UPCOMING_PAGE_SIZE) + 1 withPageSize:UPCOMING_PAGE_SIZE];
        } withAnimation:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadMoviesFromBlock:^NSArray *{
        int total;
        NSArray *arr = [RottenTomatoesProvider getUpcoming:&total withPage:1 withPageSize:UPCOMING_PAGE_SIZE];
        self.total = total;
        return arr;
    } withAnimation:YES];
    

}

@end
