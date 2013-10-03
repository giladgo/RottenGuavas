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
#import "NMPaginator.h"


@interface RottenGuavaMoviesViewController ()
@property (strong, nonatomic) UIImage *defaultPosterImage;
@end

@implementation RottenGuavaMoviesViewController

- (UIImage*)defaultPosterImage
{
    if (!_defaultPosterImage) {
        _defaultPosterImage = [UIImage imageNamed:@"poster_default.gif"];
        NSLog(@"%p", _defaultPosterImage);
    }
    return _defaultPosterImage;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.images = [[NSMutableArray alloc] init];
}

- (void) fetchFirstPage
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.paginator fetchFirstPage];
}

- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results
{
    for (Movie* movie in results) {
        [self.images addObject:self.defaultPosterImage];
    }
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    // Instead of reloading the entire tableView, do this
    NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:results.count];
    for(int i = self.paginator.results.count - results.count; i < self.paginator.results.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.paginator.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    Movie *movie = (Movie *)self.paginator.results[indexPath.row];
    cell.textLabel.text = movie.title;
    
    if (self.images[indexPath.row] == self.defaultPosterImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSLog(@"%@ %@", movie.title, movie.posterURL);
            self.images[indexPath.row] = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:movie.posterURL]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        });
        cell.imageView.image = self.defaultPosterImage; //until we load it
    }
    else {
        cell.imageView.image = self.images[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RottenGuavaMovieController *rgmc = (RottenGuavaMovieController *)[segue destinationViewController];
    Movie* movie = (Movie *)self.paginator.results[[self.tableView indexPathForSelectedRow].item];
    rgmc.movieId = movie.id;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.paginator.results.count - ([self.paginator pageSize]/2)) {
        if (![self.paginator reachedLastPage]) {
            [self.paginator fetchNextPage];
        }
    }
}

@end
