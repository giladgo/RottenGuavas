//
//  RottenTomatoesProvider.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "RottenTomatoesProvider.h"

@implementation RottenTomatoesProvider

#define API_KEY @"dcd729cesupbknfb8aqdgg59"
#define GET_MOVIE_URL @"http://api.rottentomatoes.com/api/public/v1.0/movies/%d.json?apikey=" API_KEY

+ (Movie *)getMovie:(int)movieId
{
    NSError* error;
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:[NSString stringWithFormat:GET_MOVIE_URL, movieId]]
                                         options:0 error: &error
                    ];
    NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    if (data) {
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error: &error];
        if (dict) {
            return [[Movie alloc] initWithJSON:dict];
        }
    }
    
    return nil;

}

@end
