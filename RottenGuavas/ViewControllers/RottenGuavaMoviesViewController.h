//
//  RottenGuavaMoviesViewController.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 10/1/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMPaginator.h"

@interface RottenGuavaMoviesViewController : UITableViewController <NMPaginatorDelegate>

@property (strong, nonatomic) NSMutableArray *movies; // of Movie*
@property (strong, nonatomic) NSMutableArray *images; // of UIImage*
@property (nonatomic, strong) NMPaginator *paginator;

- (void) fetchFirstPage;

- (NMPaginator*) createPaginator;

@end
