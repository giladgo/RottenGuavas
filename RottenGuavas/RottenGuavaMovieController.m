//
//  RottenGuavaViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"
#import "CastTableViewCell.h"

@interface RottenGuavaMovieController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *stars;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (nonatomic, readwrite, strong) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *director;
@property (weak, nonatomic) IBOutlet UILabel *featuring;
@property (weak, nonatomic) IBOutlet UILabel *consensus;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)updateUI;
@end

@implementation RottenGuavaMovieController

- (void)updateUI
{
    // Load the movie
    self.movie = [RottenTomatoesProvider getMovie:self.movieId];
    
    // Set the UI
	self.movieTitle.text = self.movie.title;
    self.stars.text = [self starString];
    NSURL * posterURL = [NSURL URLWithString:self.movie.posterURL];
    NSData * posterData = [NSData dataWithContentsOfURL:posterURL];
    self.poster.image = [UIImage imageWithData:posterData];
    self.director.text = (NSString*) self.movie.directors[0]; // Just show one
    self.featuring.text = [NSString stringWithFormat:@"%@, %@",  self.movie.cast[0][@"name"], self.movie.cast[1][@"name"]];
    self.consensus.text = self.movie.consensus;
    self.title = self.movie.title;
}

- (void)viewDidLoad
{
    [self updateUI];
}

- (NSString *) starString
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:5];
    [str appendString:[@"★★★★★" substringToIndex:self.movie.stars]];
    [str appendString:[@"☆☆☆☆☆" substringToIndex:5 - self.movie.stars]];
    
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
    cell.detailTextLabel.text = self.movie.cast[indexPath.row][@"characters"][0];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Cast";
    }
    
    return nil;
}

@end
