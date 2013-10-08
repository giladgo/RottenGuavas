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
#import "SearchPaginator.h"

#define SEARCH_PAGE_SIZE 50

@interface RottenGuavaSearchViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation RottenGuavaSearchViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
}

- (NMPaginator *)createPaginator
{
    SearchPaginator *paginator = [[SearchPaginator alloc] initWithPageSize:SEARCH_PAGE_SIZE delegate:self];
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
