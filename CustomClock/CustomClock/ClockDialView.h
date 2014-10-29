//
//  DialView.h
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//
//  时钟表盘视图

#import <UIKit/UIKit.h>

@interface ClockDialView : UIView

/**
 *  表盘当前值
 */
@property (nonatomic) CGFloat value;
/**
 *  时刻圆圈半径，默认为10
 */
@property (nonatomic) CGFloat circleRadius;

/**
 *  表盘最大值，默认60
 */
@property (nonatomic) NSInteger maxValue;

/**
 *  表盘最小值，默认为0
 */
@property (nonatomic) NSInteger minValue;

/**
 *  时刻圆圈个数，默认4个
 */
@property (nonatomic) NSInteger numberOfCircles;

@end
