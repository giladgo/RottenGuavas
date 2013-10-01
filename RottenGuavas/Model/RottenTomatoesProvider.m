//
//  RottenTomatoesProvider.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenTomatoesProvider.h"

@interface RottenTomatoesProvider ()
+ (NSDictionary *) doJSON:(NSString *)url;
@end

@implementation RottenTomatoesProvider
#define API_KEY @"dcd729cesupbknfb8aqdgg59"
#define GET_MOVIE_URL @"http://api.rottentomatoes.com/api/public/v1.0/movies/%d.json?apikey=" API_KEY
#define IN_THEATERS_URL @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=16&page=1&country=us&apikey=" API_KEY

+ (NSDictionary *) doJSON:(NSString *)url
{
    NSError* error;
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:url]
                                         options:0
                                           error: &error
            ];
    
    if (!data) {
        NSLog(@"Error loading JSON from server: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error: &error];
        if (!dict) {
            NSLog(@"Error parsing JSON from server: %@", [error localizedDescription]);
        }
        return dict;
    }
}


+ (Movie *)getMovie:(int)movieId
{
    return [[Movie alloc] initWithJSON:[RottenTomatoesProvider doJSON:[NSString stringWithFormat:GET_MOVIE_URL, movieId]]];
}

+ (NSArray *)getInTheaters
{
    NSDictionary* json = [RottenTomatoesProvider doJSON:IN_THEATERS_URL];
    
    return [(NSArray *)json[@"movies"] map:^id(NSDictionary* movieDict) {
        return [[Movie alloc] initWithJSON:movieDict];
    }];
}

@end
