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
@property (strong, nonatomic) NSArray *searchResults; // of Movie*
@property (strong, nonatomic) NSArray *images; // of UIImage*
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Movie *movie = (Movie *)self.searchResults[indexPath.item];
    cell.textLabel.text = movie.title;
    cell.imageView.image = self.images[indexPath.item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieSegue" sender:nil];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RottenGuavaMovieController *rgmc = (RottenGuavaMovieController *)[segue destinationViewController];
    Movie* movie = (Movie *)self.searchResults[[self.tableView indexPathForSelectedRow].item];
    rgmc.movieId = movie.id;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchResults = [RottenTomatoesProvider search:searchBar.text];
    // preload the images
    self.images = [self.searchResults map:^id(Movie* movie) {
        return [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.posterURL]]];
    }];
    
    [self.tableView reloadData];
    [searchBar endEditing:YES];
}

@end
