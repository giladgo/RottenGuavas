//
//  RottenGuavaSearchViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RGVSearchMVC.h"
#import "RGVMovieVC.h"
#import "RottenTomatoesProvider.h"
#import "RGVSearchPaginator.h"

#define SEARCH_PAGE_SIZE 50

@interface RGVSearchMVC () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation RGVSearchMVC

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (NMPaginator *)createPaginator
{
    RGVSearchPaginator *paginator = [[RGVSearchPaginator alloc] initWithPageSize:SEARCH_PAGE_SIZE delegate:self];
    paginator.searchText = self.searchBar.text;
    return paginator;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text length]) {
        [searchBar endEditing:YES];
        [self fetchFirstPage];
    }
}

@end
