//
//  RottenGuavaViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"
#import "dispatch/queue.h"
#import "RottenGuavaTrailerViewController.h"

@interface RottenGuavaMovieController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *stars;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *director;
@property (weak, nonatomic) IBOutlet UILabel *featuring;
@property (weak, nonatomic) IBOutlet UILabel *consensus;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tvHeightConstraint;

- (void)updateUI;
@end

@implementation RottenGuavaMovieController

- (void)updateUI
{
   
    // Set the UI
	self.movieTitle.text = self.movie.title;
    self.stars.text = [self starString];
    NSURL * posterURL = [NSURL URLWithString:self.movie.posterURL];
    NSData * posterData = [NSData dataWithContentsOfURL:posterURL];
    self.poster.image = [UIImage imageWithData:posterData];
    if (self.movie.directors.count) {
        self.director.text = (NSString*) self.movie.directors[0]; // Just show one
    }
    else {
        self.director.text = nil;
    }
    if (self.movie.cast.count > 1) {
        self.featuring.text = [NSString stringWithFormat:@"%@, %@",  self.movie.cast[0][@"name"], self.movie.cast[1][@"name"]];
    }
    else if (self.movie.cast.count) {
        self.featuring.text = self.movie.cast[0][@"name"];
    }
    else {
        self.featuring.text = nil;
    }
    
    self.consensus.text = self.movie.consensus;
    self.title = self.movie.title;
    [self.tableView reloadData];
    
    if (self.movie.cast.count) {
        CGFloat totalHeight = self.tableView.rowHeight * [self.movie.cast count] + self.tableView.sectionHeaderHeight;
        NSLog(@"totalHeight = %f", totalHeight);
        self.tvHeightConstraint.constant = totalHeight;
        [self.view layoutSubviews];
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
    }
}

- (void)viewDidLoad
{
    [self updateUI];
}

- (NSString *) starString
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:5];
    
    if (self.movie) {
        [str appendString:[@"★★★★★" substringToIndex:self.movie.stars]];
        [str appendString:[@"☆☆☆☆☆" substringToIndex:5 - self.movie.stars]];
    }
    
    return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movie.cast.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CastCell" forIndexPath:indexPath];
    cell.textLabel.text = self.movie.cast[indexPath.row][@"name"];
    NSArray *characters = (NSArray *)self.movie.cast[indexPath.row][@"characters"];
    if (characters.count) {
        cell.detailTextLabel.text = characters[0];
    }
    return cell;
}


- (IBAction)viewTrailer:(id)sender {
    [self performSegueWithIdentifier:@"Trailer" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Trailer"]) {
        RottenGuavaTrailerViewController *rgtvc = (RottenGuavaTrailerViewController *)segue.destinationViewController;
        rgtvc.movie = self.movie;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Cast";
    }
    
    return nil;
}



@end
