//
//  RottenGuavaTopMoviesViewController.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenGuavaTopMoviesViewController.h"
#import "RottenGuavaMovieController.h"
#import "RottenTomatoesProvider.h"

@interface RottenGuavaTopMoviesViewController ()
@end

@implementation RottenGuavaTopMoviesViewController


- (void)viewDidLoad
{
    [self loadMoviesFromBlock:^NSArray *{
        return [RottenTomatoesProvider getInTheaters];
    }];
    
}
@end
