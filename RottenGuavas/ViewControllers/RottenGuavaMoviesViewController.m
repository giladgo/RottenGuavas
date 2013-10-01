//
//  RottenGuavaMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaMoviesViewController.h"
#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"
#import "Movie.h"
#import "MBProgressHUD.h"
#import "dispatch/queue.h"


@interface RottenGuavaMoviesViewController ()

@end

@implementation RottenGuavaMoviesViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    Movie *movie = (Movie *)self.movies[indexPath.item];
    cell.textLabel.text = movie.title;
    if ([self.images[indexPath.item] isKindOfClass:[UIImage class]]) {
        cell.imageView.image = self.images[indexPath.item];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieSegue" sender:nil];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RottenGuavaMovieController *rgmc = (RottenGuavaMovieController *)[segue destinationViewController];
    Movie* movie = (Movie *)self.movies[[self.tableView indexPathForSelectedRow].item];
    rgmc.movieId = movie.id;
}

- (void)loadMoviesFromBlock:(NSArray*(^)(void))block
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    dispatch_queue_t dq = dispatch_queue_create("load movies", NULL);
    dispatch_async(dq, ^{
        if (!self.movies || !self.movies.count){
            self.movies = block();
            
            // load the images
            self.images = [[NSMutableArray alloc] initWithCapacity:self.movies.count];
            for (int i = 0; i < self.movies.count; i++) {
                [self.images addObject:[NSNull null]];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    Movie *movie = self.movies[i];
                    self.images[i] = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.posterURL]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    });
                });
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}
@end
