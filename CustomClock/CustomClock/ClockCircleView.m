//
//  CircleView.m
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "ClockCircleView.h"

@implementation ClockCircleView

#pragma mark - View Lifecycle

-(ClockCircleView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setDefaultValues];
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    _imageView = [[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView.layer setMasksToBounds:YES];
    [self addSubview:_imageView];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setBackgroundColor:[UIColor clearColor]];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    _textLabel.textColor = _textColor;
    [self addSubview:_textLabel];
    
    //Debug
    _textLabel.text = @"t";
}

/**
 *  设置默认属性值
 */
-(void)setDefaultValues
{
    _angle  = 0;
    _lineWidth  = 1;
    _minAngle   = 0;
    _maxAngle   = 360;
    _lineColor  = [UIColor redColor];
    _fillColor  = [UIColor clearColor];
    _textColor  = [UIColor redColor];
}

#pragma mark - Setter And Getter

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

-(void)setAngle:(CGFloat)angle
{
    _angle = angle;
    [self setNeedsDisplay];
}

-(void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

#pragma mark - Drawing Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    [_textLabel setFrame:frame];
    _textLabel.font = [UIFont systemFontOfSize:CGRectGetWidth(frame)/2];
    
    CGRect imageViewFrame = CGRectIntegral(CGRectInset(frame, _lineWidth, _lineWidth));
    [_imageView setFrame:imageViewFrame];
    
    CGFloat imageViewCornerRadius = (CGRectGetWidth(imageViewFrame) / 2.f);
    [_imageView.layer setCornerRadius:imageViewCornerRadius];
}

-(void)drawRect:(CGRect)rect
{

    //  获取设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);

    //  设置画笔属性
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextFillRect(context, self.bounds);
    CGContextSetLineWidth(context, _lineWidth);
    
    //  画圆
    CGRect circleRect = CGRectInset(self.bounds, _lineWidth, _lineWidth);
    CGContextAddArc(context, CGRectGetMidX(circleRect), CGRectGetMidY(circleRect), MIN(CGRectGetWidth(circleRect), CGRectGetHeight(circleRect)) / 2.f, radians(0), radians(360), NO);
    
    CGContextStrokePath(context);
    
}

#pragma mark - Public Method

-(void)clearInnerLine
{
    //  取出并保存上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    //  设置区域并清除
    CGRect clippingEllipseRect = self.frame;
    CGContextAddEllipseInRect(context, clippingEllipseRect);
    CGContextClip(context);
    CGContextClearRect(context, clippingEllipseRect);
    
    //  恢复上下文
    CGContextRestoreGState(context);
}

#pragma mark - Private Method
@end
