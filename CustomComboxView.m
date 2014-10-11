//
//  CustomComboxView.m
// 
//
//  Created by 许启强 on 14-10-10.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "CustomComboxView.h"

@implementation CustomComboxView

#pragma mark - View Lifeciycle
//调用者调用这个方法，调用者只能为UIView或者UIViewController
-(CustomComboxView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor grayColor]CGColor];
    if (self) {
        [self initSubViews];
    }
    return self;
}

//放在xib中时调用
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor grayColor]CGColor];
    if (self) {
        [self initSubViews];
    }
}

#pragma mark - Init Methods

//加载子视图
-(void)initSubViews
{
    //输入框宽度为下拉表view的3/4,高度同高
    CGRect frame = CGRectMake(0, 0 , 3/4.0 * self.frame.size.width, self.frame.size.height);
    _lab_Input = [[UILabel alloc]initWithFrame:frame];
    _lab_Input.textAlignment = NSTextAlignmentCenter;
    _lab_Input.text = @"something";
    
    _lab_Input.layer.borderWidth = 0.5;
    _lab_Input.layer.borderColor = [[UIColor grayColor]CGColor];
    
    [self addSubview:_lab_Input];
    
    //展开按钮宽度为下拉表view的1/4，高度同高
    frame = CGRectMake(_lab_Input.frame.origin.x + _lab_Input.frame.size.width, 0 , 1/4.0 * self.frame.size.width, _lab_Input.frame.size.height);
    _btn_Open = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_Open.backgroundColor = [UIColor grayColor];
    
    _btn_Open.userInteractionEnabled = YES;
    
    _btn_Open.frame = frame;
    
    //设定button展开引导
    [_btn_Open setTitle:@"▼" forState:UIControlStateNormal];
    [_btn_Open setTitle:@"▲" forState:UIControlStateSelected];
    
    //添加展开方法
    [_btn_Open addTarget:self action:@selector(openComboxTable) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn_Open];
}

//点击展开按钮btn_Open调用这个方法
-(void)openComboxTable
{
    //如果下拉选择表为空，则创建
    if (_comboxTabel == nil) {
        CGRect frame;
        //下拉选择表紧跟下面生成
        frame.origin = CGPointMake(self.frame.origin.x,self.frame.origin.y + self.frame.size.height);
        frame.size   = CGSizeMake(self.frame.size.width, 120);
        
        _comboxTabel = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _comboxTabel.dataSource = self;
        _comboxTabel.delegate   = self;
        
        _comboxTabel.autoresizingMask = NO;
        
        _comboxTabel.rowHeight = 30;
        _comboxTabel.showsVerticalScrollIndicator = NO;
        _comboxTabel.backgroundColor = [UIColor lightGrayColor];
        
        //判断调用者类型，只能为UIView或者UIViewController
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            UIViewController *VC = (UIViewController *)self.delegate;
            [VC.view addSubview:_comboxTabel];
        }
        else if([self.delegate isKindOfClass:[UIView class]]){
            UIView *view = (UIView *)self.delegate;
            [view addSubview:_comboxTabel];
        }
        else
        {
            NSLog(@"error");
        }
        
        //设定button状态为选择
        _btn_Open.selected = YES;
    } else{
        
        //设定下拉选择表的隐藏属性以及button是否选择
        _comboxTabel.hidden = !_comboxTabel.hidden;
        _btn_Open.selected = !_btn_Open.selected;
    }
}

#pragma mark - UITableView Delagate

//请求下拉列表行数，由调用者实现代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate numberOfRowsInCombox];
}

//请求下拉列表每行内容，调用者实现代理方法传入NSString类型的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    //调用者实现代理方法传入NSString类型的内容
    cell.textLabel.text = [self.delegate Combox:self contentforRow:indexPath.row];

    return cell;
}

//选择某行后的反应，由调用者实现代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate Combox:self didselectRow:indexPath.row];
}
@end
