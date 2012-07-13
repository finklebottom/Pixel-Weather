//
//  WeatherTableCell.m
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import "WeatherTableCell.h"

@implementation WeatherTableCell

@synthesize weekday = _weekday;
@synthesize date = _date;
@synthesize HILO = _HILO;
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
