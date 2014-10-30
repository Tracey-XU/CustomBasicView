//
//  DialView.m
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//


#import "ClockDialView.h"
#import "ClockCircleView.h"

@implementation ClockDialView

#pragma mark - View Lifecycle

-(ClockDialView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setDefaultValues];
    }
    
    return self;
}

/**
 *  设置默认属性值
 */
-(void)setDefaultValues
{
    _value = 0;
    _circleRadius  = 15;
    _minValue      = 0;
    _maxValue      = 60;
    _numberOfCircles = 4;
}

#pragma mark - Setter And Getter

-(void)setCircleRadius:(CGFloat)circleRadius
{
    _circleRadius = circleRadius;
    
    [self setNeedsDisplay];
}

-(void)setNumberOfCircles:(NSInteger)numberOfCircles
{
    _numberOfCircles = numberOfCircles;
    
    [self setNeedsDisplay];
}

-(void)setValue:(CGFloat)value
{
    _value = value;
    [self setNeedsDisplay];
}

#pragma mark - Drawing Method

- (void)drawRect:(CGRect)rect {
    
    //获取上下文环境
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
    CGContextAddEllipseInRect(context, CGRectMake(_circleRadius, _circleRadius, CGRectGetWidth(rect)-2*_circleRadius, CGRectGetHeight(rect)-2*_circleRadius));
    CGContextStrokePath(context);
    
    if (_value == 0 || _value == _maxValue) {
        CGContextSaveGState(context);
         CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
        CGContextAddEllipseInRect(context, CGRectMake(_circleRadius, _circleRadius, CGRectGetWidth(rect)-2*_circleRadius, CGRectGetHeight(rect)-2*_circleRadius));
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    } else {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 3);
        CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), CGRectGetHeight(rect)/2-_circleRadius, radians([self angleWithValue:0]), +radians([self angleWithValue:_value]), 0);
        NSLog(@"%f",[self angleWithValue:_value]);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }

    
    //画四个时刻圆圈
    for (int i =0; i< _numberOfCircles; i++) {
        ClockCircleView *item = [[ClockCircleView alloc]init];
        item.angle = i*360/_numberOfCircles;
        item.frame = [self dotRectWithAngle:item.angle];
        item.backgroundColor = [UIColor clearColor];
        item.textLabel.text = [NSString stringWithFormat:@"%ld",i*(_maxValue-_minValue)/(_numberOfCircles)];
        [item clearInnerLine];
        [self addSubview:item];
    }
}

#pragma mark - Private Method

/**
 *  根据角度求rect
 *
 *  @param angle 时刻圆圈的角度，竖直向上为0
 *
 *  @return 时刻圆圈的rect
 */
- (CGRect)dotRectWithAngle:(CGFloat)angle {
    
    CGFloat radians = radians(angle);
    CGFloat radius = CGRectGetWidth(self.frame)/2.f - _circleRadius;
    CGPoint middleCirclePoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint center = CGPointMake(middleCirclePoint.x + radius * sin(radians), middleCirclePoint.y - radius * cos(radians));
    CGSize size = CGSizeMake(_circleRadius * 2, _circleRadius * 2);
    CGRect rect = CGRectIntegral(CGRectMake(center.x - _circleRadius, center.y - _circleRadius, size.width, size.height));
    
    return rect;
}

-(CGFloat)angleWithValue:(NSInteger)value
{
    return 270+((CGFloat)value/_maxValue)*360;
}

@end
