//
//  CheckBoxView.m
//  linggongzi
//
//  Created by 许启强 on 14-10-16.
//  Copyright (c) 2014年 jinghao. All rights reserved.
//

#import "CheckBoxView.h"

@implementation CheckBoxView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initCheckBox];
    }
    return self;
}

-(void)initCheckBox
{
    _btn_Select = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_Select.frame = CGRectMake(0, 0, 40, 40);
    self.backgroundColor = [UIColor redColor];
    _btn_Select.backgroundColor = [UIColor redColor];
    [_btn_Select setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateSelected];
    [_btn_Select setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
    [_btn_Select addTarget:self action:@selector(select_Onclick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn_Select];
    
    _lab_Hint   = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.frame.size.width - 40, 40)];
    [self addSubview:_lab_Hint];
}

-(void)select_Onclick
{
    _btn_Select.selected = !_btn_Select.selected;
}
@end
