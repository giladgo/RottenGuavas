//
//  RottenTomatoesProvider.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface RottenTomatoesProvider : NSObject

+ (Movie *)getMovie:(int) movieId;

@end
