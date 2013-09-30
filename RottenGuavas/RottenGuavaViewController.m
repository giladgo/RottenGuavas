//
//  RottenGuavaViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaViewController.h"
#import "RottenTomatoesProvider.h"

@interface RottenGuavaViewController ()
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *stars;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (nonatomic, readwrite, strong) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *director;
@property (weak, nonatomic) IBOutlet UILabel *featuring;
@end

@implementation RottenGuavaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the movie
    self.movie = [RottenTomatoesProvider getMovie:23532];
    
    // Set the UI
	self.movieTitle.text = self.movie.title;
    self.stars.text = [self starString];
    NSURL * posterURL = [NSURL URLWithString:self.movie.posterURL];
    NSData * posterData = [NSData dataWithContentsOfURL:posterURL];
    self.poster.image = [UIImage imageWithData:posterData];
    self.director.text = (NSString*) self.movie.directors[0]; // Just show one
    self.featuring.text = [NSString stringWithFormat:@"%@, %@",  self.movie.cast[0], self.movie.cast[1]];
}

- (NSString *) starString
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:5];
    [str appendString:[@"★★★★★" substringToIndex:self.movie.stars]];
    [str appendString:[@"☆☆☆☆☆" substringToIndex:5 - self.movie.stars]];
    
    return str;
}


@end
