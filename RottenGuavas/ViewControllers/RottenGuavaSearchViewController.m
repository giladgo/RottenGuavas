//
//  RottenGuavaSearchViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaSearchViewController.h"
#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"
#import "Movie.h"

#define SEARCH_PAGE_SIZE 50

@interface RottenGuavaSearchViewController () <UISearchBarDelegate>

@end

@implementation RottenGuavaSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* searchText = searchBar.text;
    [self loadMoviesFromBlock:^NSArray *{
        NSArray *arr =  [RottenTomatoesProvider search:searchText withTotal:NULL withPage:1 withPageSize:SEARCH_PAGE_SIZE];
        return arr;
    } withAnimation:YES];
    
    [searchBar endEditing:YES];
}

@end
