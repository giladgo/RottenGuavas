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
    return [[RGVSearchPaginator alloc] initWithPageSize:SEARCH_PAGE_SIZE delegate:self];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.paginator isKindOfClass:[RGVSearchPaginator class]]) {
        RGVSearchPaginator *paginator = (RGVSearchPaginator *)self.paginator;
        paginator.searchText = searchBar.text;
        if ([searchBar.text length]) {
            [searchBar endEditing:YES];
            [self fetchFirstPage];
        }
    }
    
}
- (IBAction)tableTap:(id)sender {
    [self.searchBar resignFirstResponder];
}


@end
