//
//  CastTableViewCell.m
//  RottenGuavas
//
//  Created by Gilad Goldberg on 9/30/13.
//  Copyright (c) 2013 Gilad Goldberg. All rights reserved.
//

#import "CastTableViewCell.h"

@implementation CastTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
