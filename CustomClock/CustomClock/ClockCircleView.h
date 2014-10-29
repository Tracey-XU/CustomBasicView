//
//  CircleView.h
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//
//  时刻圆圈视图

#import <UIKit/UIKit.h>

#define radians(x) (x * M_PI / 180)
#define degrees(x) (x * 180 / M_PI)

@interface ClockCircleView : UIView

#pragma mark - Property

/**
 *  线宽，默认为1
 */
@property (nonatomic) CGFloat lineWidth;

/**
 *  线的颜色，默认为红色redcolor
 */
@property (nonatomic) UIColor *lineColor;

/**
 *  填充色，默认clearColor.
 */
@property (nonatomic) UIColor *fillColor;

/**
 *  文字颜色，默认红色redcolor
 */
@property (nonatomic) UIColor *textColor;
/**
 *  内容标签，默认无
 */
@property (nonatomic, readonly) UILabel *textLabel;

/**
 *  圈内图片，默认无
 */
@property (nonatomic, readonly) UIImageView *imageView;

/**
 *  当前角度，默认为0
 */
@property (nonatomic) CGFloat angle;

/**
 *  最小角度，默认为0
 */
@property (nonatomic) CGFloat minAngle;

/**
 *  最大角度，默认360
 */
@property (nonatomic) CGFloat maxAngle;

#pragma mark - Public Method

/**
 *  清除时刻圆圈内部弧线
 */
-(void)clearInnerLine;

@end
