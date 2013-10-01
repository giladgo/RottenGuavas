//
//  RottenGuavaTopMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaTopMoviesViewController.h"
#import "RottenTomatoesProvider.h"
#import "RottenGuavaMovieController.h"
#import "MBProgressHUD.h"
#import "dispatch/queue.h"

@interface RottenGuavaTopMoviesViewController ()
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSArray *images; // of UIImage
@end

@implementation RottenGuavaTopMoviesViewController

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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_queue_t dq = dispatch_queue_create("load top movies", NULL);
    dispatch_async(dq, ^{
        if (!self.movies || !self.movies.count){
            self.movies = [RottenTomatoesProvider getInTheaters];
            [self.tableView reloadData];
            
            // preload the images
            self.images = [self.movies map:^id(Movie* movie) {
                return [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.posterURL]]];
            }];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Movie *movie = (Movie *)self.movies[indexPath.item];
    cell.textLabel.text = movie.title;
    cell.imageView.image = self.images[indexPath.item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RottenGuavaMovieController *rgmc = (RottenGuavaMovieController *)[segue destinationViewController];
    Movie* movie = (Movie *)self.movies[[self.tableView indexPathForSelectedRow].item];
    rgmc.movieId = movie.id;
    
}

@end
