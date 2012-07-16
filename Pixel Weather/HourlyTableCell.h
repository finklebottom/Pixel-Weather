//
//  HourlyTableCell.h
//  Pixel Weather
//
//  Created by colin gleeson on 12-07-15.
//  Copyright (c) 2012 colin gleeson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourlyTableCell : UITableViewCell
{
    IBOutlet UILabel *hour;
    IBOutlet UILabel *temp;
    IBOutlet UILabel *wet;
    IBOutlet UILabel *snow;
    IBOutlet UILabel *condition;
    IBOutlet UIImageView *conditionImage;
    
}

@property (nonatomic,weak) IBOutlet UILabel *hour;
@property (nonatomic,weak) IBOutlet UILabel *temp;
@property (nonatomic,weak) IBOutlet UILabel *wet;
@property (nonatomic,weak) IBOutlet UILabel *snow;
@property (nonatomic,weak) IBOutlet UILabel *condition;
@property (nonatomic,weak) IBOutlet UIImageView *conditionImage;



@end
