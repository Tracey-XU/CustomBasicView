//
//  MonthTableCollectionViewCell.m
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "MonthTableCollectionViewCell.h"

@implementation MonthTableCollectionViewCell

-(MonthTableCollectionViewCell *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews
{
    _btn_Day = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn_Day.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self addSubview:_btn_Day];
}
@end
