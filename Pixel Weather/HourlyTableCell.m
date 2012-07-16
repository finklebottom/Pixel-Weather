//
//  HourlyTableCell.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-15.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "HourlyTableCell.h"

@implementation HourlyTableCell

@synthesize hour = _hour;
@synthesize temp = _temp;
@synthesize wet = _wet;
@synthesize snow = _snow;
@synthesize condition = _condition;
@synthesize conditionImage = _conditionImage;

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
