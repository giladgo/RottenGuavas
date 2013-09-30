//
//  Movie.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithJSON: (NSDictionary*) json
{
    self = [super init];
    if (self) {
        self.id = [(NSNumber *)json[@"id"] intValue];
        self.title = json[@"title"];
        self.criticsRating = [(NSNumber *)json[@"ratings"][@"critics_score"] intValue];
        self.posterURL = json[@"posters"][@"detailed"];
        self.directors = [(NSArray* )json[@"abridged_directors"] map:^id(NSDictionary* obj) {
            return obj[@"name"];
        }];
        self.cast = (NSArray* )json[@"abridged_cast"];
        self.consensus = json[@"critics_consensus"];
    }
    return self;
}

- (int) stars {
    return self.criticsRating / 20;
}

@end
