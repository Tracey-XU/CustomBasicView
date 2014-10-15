//
//  CustomCalenderView.m
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "CustomCalenderView.h"
#import "HeaderView.h"
#import "MonthTableView.h"

@implementation CustomCalenderView

-(CustomCalenderView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [self addSubview:headerView];
    
    MonthTableView *monthTable = [[MonthTableView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.width - 30)];
    [self addSubview:monthTable];
}
@end
