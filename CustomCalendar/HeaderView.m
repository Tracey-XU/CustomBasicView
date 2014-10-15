//
//  HeaderView.m
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(HeaderView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

-(void)initSubViews
{
    UIButton *btn_Previous = [UIButton buttonWithType:UIButtonTypeSystem];
    btn_Previous.frame  =   CGRectMake(0, 0, 20, 20);
    [self addSubview:btn_Previous];
    
    UILabel *lab_Title  =   [[UILabel alloc]initWithFrame:CGRectMake(20,0, self.frame.size.width - 40, self.frame.size.height)];
    lab_Title.textAlignment =   NSTextAlignmentCenter;
    
    UIButton *btn_Next = [UIButton buttonWithType:UIButtonTypeSystem];
    btn_Previous.frame  =   CGRectMake(self.frame.size.width - 20, 0, 20, 20);
    [self addSubview:btn_Next];
    
    //Debug
    btn_Previous.backgroundColor = [UIColor orangeColor];
    btn_Next.backgroundColor     = [UIColor orangeColor];
}
@end
