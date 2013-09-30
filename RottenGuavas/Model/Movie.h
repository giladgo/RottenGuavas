//
//  Movie.h
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic) int id;
@property (strong, nonatomic) NSString *title;
@property (nonatomic) int criticsRating;
@property (strong, nonatomic) NSString *posterURL;
@property (readonly, nonatomic) int stars;
@property (strong, nonatomic) NSArray *directors; // of NSString*
@property (strong, nonatomic) NSArray *cast; // of NSString*


- (id)initWithJSON: (NSDictionary*) json;

@end