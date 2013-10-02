//
//  RottenGuavaMoviesViewController.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RottenGuavaMoviesViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *movies; // of Movie*
@property (strong, nonatomic) NSMutableArray *images; // of UIImage*

- (void)loadMoviesFromBlock:(NSArray*(^)(void))block withAnimation:(BOOL)anim;
@end
