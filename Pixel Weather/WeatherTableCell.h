//
//  WeatherTableCell.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-12.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableCell : UITableViewCell
{
    IBOutlet UILabel *weekday;
    IBOutlet UILabel *date;
    IBOutlet UILabel *HILO;
    IBOutlet UILabel *wet;
    IBOutlet UILabel *snow;
    IBOutlet UILabel *condition;
    IBOutlet UIImageView *conditionImage;

}

@property (nonatomic,weak) IBOutlet UILabel *weekday;
@property (nonatomic,weak) IBOutlet UILabel *date;
@property (nonatomic,weak) IBOutlet UILabel *HILO;
@property (nonatomic,weak) IBOutlet UILabel *wet;
@property (nonatomic,weak) IBOutlet UILabel *snow;
@property (nonatomic,weak) IBOutlet UILabel *condition;
@property (nonatomic,weak) IBOutlet UIImageView *conditionImage;


@end
