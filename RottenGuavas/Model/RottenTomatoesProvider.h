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

+ (NSArray *)getInTheaters:(int*)total withPage:(int)page withPageSize:(int)pageSize; // of Movie*
+ (NSArray *)search:(NSString*)query withTotal:(int*)total withPage:(int)page  withPageSize:(int)pageSize;  // of Movie*
+ (NSArray *)getUpcoming:(int*)total withPage:(int)page withPageSize:(int)pageSize; // of Movie*

@end
