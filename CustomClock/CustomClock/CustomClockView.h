//
//  CustomClockView.h
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//
//  自定义时钟视图

#import <UIKit/UIKit.h>

@interface CustomClockView : UIView

#pragma mark -Property
/**
 *  分钟表盘与时钟表盘间距,默认为10
 */
@property (nonatomic)CGFloat space;

#pragma mark - Public Methods

/**
 *  开启时钟，默认开
 */
-(void)startClock;

/**
 *  停止时钟
 */
-(void)stopClock;

@end
