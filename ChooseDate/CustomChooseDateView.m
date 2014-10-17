//
//  CustomChooseDateView.m
//  linggongzi
//
//  Created by 许启强 on 14-10-12.
//  Copyright (c) 2014年 jinghao. All rights reserved.
//

#import "CustomChooseDateView.h"
#import "UIView+Custom.h"

@implementation CustomChooseDateView

#define kONETHIIRDSHEIGHT   self.frame.size.height / 3    //高度的三分之一
#define kHALFWIDTH          self.frame.size.width  / 2    //宽度的二分之一

//初始化方法，代理为实现了UIComboboxDelegate的代理方法
-(CustomChooseDateView *)initWithFrame:(CGRect)frame AndDelegae:(id<UIComboboxDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = delegate;
        [self initSubViews];
        [self initDimControl];
    }
    
    return self;
}

-(void)initSubViews
{
    //开始时间块
    UILabel *lab_Start = [[UILabel alloc]initWithFrame:CGRectMake(5, 5,self.width - 10 , kONETHIIRDSHEIGHT / 2 - 10)];
    lab_Start.text = @"开始年月";
    _startYear  = [[CustomComboboxView alloc]initWithFrame:CGRectMake(lab_Start.left,lab_Start.bottom + 10, kHALFWIDTH - 20, lab_Start.height)];
    _startMonth = [[CustomComboboxView alloc]initWithFrame:CGRectMake(_startYear.right + 30, _startYear.top, _startYear.width,_startYear.height)];
    
    [self addSubview:lab_Start];
    [self addSubview:_startYear];
    [self addSubview:_startMonth];
    
    //结束时间块
    UILabel *lab_Stop = [[UILabel alloc]initWithFrame:CGRectMake(lab_Start.left, _startYear.bottom +  30,lab_Start.width, lab_Start.height)];
    lab_Stop.text = @"结束年月";
    _stopYear  = [[CustomComboboxView alloc]initWithFrame:CGRectMake(lab_Start.left,lab_Stop.bottom + 10, kHALFWIDTH - 20, lab_Stop.height)];
    _stopMonth = [[CustomComboboxView alloc]initWithFrame:CGRectMake(_stopYear.right + 30, _stopYear.top, _stopYear.width,_stopYear.height)];
    
    [self addSubview:lab_Stop];
    [self addSubview:_stopYear];
    [self addSubview:_stopMonth];
    
    //统计button块
    _btn_Calculate = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn_Calculate.frame = CGRectMake(lab_Start.left, _stopYear.bottom + 20 , lab_Start.width,_startYear.height + 10);
    [_btn_Calculate setTitle:@"累计汇总" forState:UIControlStateNormal];
    _btn_Calculate.backgroundColor = [UIColor orangeColor];
    [_btn_Calculate fillet:_btn_Calculate.height / 2];
    [self addSubview:_btn_Calculate];
    
    //设定tag，方便调用者判读
    _startYear.tag  = kSTARTYEAR;
    _startMonth.tag = kSTARTMONTH;
    _stopYear.tag   = kSTOPYEAR;
    _stopMonth.tag  = kSTOPMONTH;
    
    //设下拉表定单位
    _startYear.lab_Detail.text  = @"年";
    _startMonth.lab_Detail.text = @"月";
    _stopYear.lab_Detail.text   = @"年";
    _stopMonth.lab_Detail.text  = @"月";
    
    //设定代理，ChooseDateView调用者实现CustomComboxView的代理
    _startYear.delegate     = self.delegate;
    _startMonth.delegate    = self.delegate;
    _stopYear.delegate      = self.delegate;
    _stopMonth.delegate     = self.delegate;
}

//加载模糊视图，展开下拉列表事加载。
-(void)initDimControl
{
    _dimControl=[[UIControl alloc]initWithFrame:self.bounds];
    _dimControl.hidden=YES;
    [_dimControl setBackgroundColor:[UIColor clearColor]];
    [_dimControl addTarget:self action:@selector(controlAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dimControl];
}

#pragma mark - Private Methods
//点击模糊视图是调用
-(void)controlAction
{
    _currentCombobox.comboboxTabel.hidden = YES;
    _dimControl.hidden = YES;
}

@end
