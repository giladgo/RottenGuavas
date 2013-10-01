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
        return [RottenTomatoesProvider search:searchText];
    }];
    
    [searchBar endEditing:YES];
}

@end
