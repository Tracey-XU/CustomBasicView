//
//  CustomClockView.m
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "CustomClockView.h"
#import "ClockDialView.h"

@implementation CustomClockView
{
    ClockDialView   *_dialHour;
    ClockDialView   *_dialMinute;
    UILabel         *_labTime;
}

#pragma mark - View Lifecycle
/**
 *  frame应当为正方形
 */
-(CustomClockView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self setDefaultValues];
        
        [self initSubViews];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }

    return self;
}

/**
 *  设置默认属性值
 */
-(void)setDefaultValues
{
    _space = 10;
}

/**
 *  加载子视图
 */
-(void)initSubViews
{
    _dialMinute = [[ClockDialView alloc]initWithFrame:CGRectZero];
    _dialMinute.backgroundColor = [UIColor clearColor];
    _dialMinute.circleRadius = 15;
    [self addSubview:_dialMinute];
    
    _dialHour = [[ClockDialView alloc]initWithFrame:CGRectZero];
    _dialHour.backgroundColor = [UIColor clearColor];
    _dialHour.circleRadius = 10;
    _dialMinute.maxValue = 12;
    [self addSubview:_dialHour];
    
    _labTime = [[UILabel alloc]initWithFrame:CGRectZero];
    _labTime.textColor = [UIColor redColor];
    _labTime.textAlignment = NSTextAlignmentCenter;
    _labTime.text = @"00:00:00";
    [self addSubview:_labTime];
}

-(void)layoutSubviews
{
    _dialMinute.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _dialHour.frame  = CGRectMake(2*_dialMinute.circleRadius+_space,2*_dialMinute.circleRadius+_space,CGRectGetWidth(self.frame)- 4*_dialMinute.circleRadius-2*_space, CGRectGetHeight(self.frame)-4*_dialMinute.circleRadius-2*_space);
    _labTime.frame = CGRectMake(CGRectGetMinX(_dialHour.frame)+2*_dialHour.circleRadius, CGRectGetMidY(_dialHour.frame)-15, CGRectGetWidth(self.frame)-4*_dialMinute.circleRadius-4*_dialHour.circleRadius-2*_space, 30);
}

#pragma mark - Private Methods

-(void)updateTime
{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar  *greCarlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [greCarlendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    //获取时分秒
    NSInteger hour = [dateCompoment hour];
    NSInteger min = [dateCompoment minute];
    NSInteger sec = [dateCompoment second];
    
    //更新显示时间
    NSString *timeString;
    if (hour<10) {
        if (min<10) {
            if (sec<10) {
                timeString = [NSString stringWithFormat:@"0%ld:0%ld:0%ld",hour,min,sec];
            } else {
                timeString = [NSString stringWithFormat:@"0%ld:0%ld:%ld",hour,min,sec];
            }
        } else {
            if (sec<10){
                timeString = [NSString stringWithFormat:@"0%ld:%ld:0%ld",hour,min,sec];
            } else {
                timeString = [NSString stringWithFormat:@"0%ld:%ld:0%ld",hour,min,sec];
            }
        }
    }else {
        if (min<10) {
            if (sec<10) {
                timeString = [NSString stringWithFormat:@"%ld:0%ld:0%ld",hour,min,sec];
            } else {
                timeString = [NSString stringWithFormat:@"%ld:0%ld:%ld",hour,min,sec];
            }
        } else {
            if (sec<10){
                timeString = [NSString stringWithFormat:@"%ld:%ld:0%ld",hour,min,sec];
            } else {
                timeString = [NSString stringWithFormat:@"%ld:%ld:%ld",hour,min,sec];
            }
        }
    }
    _labTime.text = timeString;
}
@end
