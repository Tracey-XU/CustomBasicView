//
//  CustomComboboxView.m
// 
//
//  Created by 许启强 on 14-10-10.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "CustomComboboxView.h"
#import "UIViewExt.h"

@implementation CustomComboboxView

#pragma mark - View Lifeciycle

-(CustomComboboxView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

//放在xib中时调用
-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self) {
        [self initSubViews];
    }
}

#pragma mark - Init Methods

//加载子视图
-(void)initSubViews
{
    //输入框宽度为下拉表view宽度减去两倍高度（展开按钮和细节标签）,高度同高
    CGRect frame = CGRectMake(0,0,self.frame.size.width - 2*self.frame.size.height, self.frame.size.height);
    _lab_Input = [[UILabel alloc]initWithFrame:frame];
    _lab_Input.textAlignment = NSTextAlignmentCenter;
    _lab_Input.text = @"content";
    
    _lab_Input.layer.borderWidth = 0.5;
    _lab_Input.layer.borderColor = [[UIColor grayColor]CGColor];
    
    [self addSubview:_lab_Input];
    
    //展开按钮宽度为下拉表view的高度，高度同高
    frame = CGRectMake(_lab_Input.frame.size.width + _lab_Input.frame.origin.x, 0 , self.frame.size.height, _lab_Input.frame.size.height);
    _btn_Open = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_Open.frame = frame;
    _btn_Open.backgroundColor = [UIColor grayColor];
    
    _btn_Open.userInteractionEnabled = YES;
    
    //设定button展开引导
    [_btn_Open setTitle:@"▼" forState:UIControlStateNormal];
    [_btn_Open setTitle:@"▲" forState:UIControlStateSelected];
    
    //添加展开方法
    [_btn_Open addTarget:self action:@selector(openComboxTable:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn_Open];
    
    //单位标签宽度为下拉表view的高度，高度同高
    frame = CGRectMake(_btn_Open.frame.size.width + _btn_Open.frame.origin.x, 0 , _btn_Open.frame.size.height, _lab_Input.frame.size.height);
    _lab_Detail = [[UILabel alloc]initWithFrame:frame];
    _lab_Detail.adjustsFontSizeToFitWidth = YES;
    _lab_Detail.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_Detail];
    
    
//    NSLog(@"rfrse%@",[self.superview class]);
//    _ctrl=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    [_ctrl setBackgroundColor:[UIColor redColor]];
//    [self.superview addSubview:_ctrl];
    
}

//点击展开按钮btn_Open调用这个方法
-(void)openComboxTable:(UIButton *)sender
{
    if ([[self superview]respondsToSelector:@selector(setCurrentCombobox:)]) {
        [self superview]
        _currentCombobox = self;
    }
   
    //如果下拉选择表为空，则创建
    if (_comboboxTabel == nil) {
        
        if (_ctrl == nil) {
            [self initDimControl];
        }
        
        CGRect frame;
        //下拉选择表紧跟下面生成
        frame.origin = CGPointMake(self.frame.origin.x,self.frame.origin.y + self.frame.size.height);
        frame.size   = CGSizeMake(self.frame.size.width - self.frame.size.height, 120);
        
        _comboboxTabel = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _comboboxTabel.dataSource = self;
        _comboboxTabel.delegate   = self;
        
        _comboboxTabel.autoresizingMask = NO;
        
        _comboboxTabel.rowHeight = 30;
        _comboboxTabel.showsVerticalScrollIndicator = NO;
        _comboboxTabel.backgroundColor = [UIColor lightGrayColor];
        
        //添加到父类中
        [[self superview] addSubview:_comboboxTabel];
        [self.superview bringSubviewToFront:_comboboxTabel];
        
        _currentCombobox = self;
        
        //设定button状态为选择
        _btn_Open.selected = YES;
        _ctrl.hidden = NO;
    } else{
        
        //设定下拉选择表的隐藏属性以及button是否选择
        _comboboxTabel.hidden = !_comboboxTabel.hidden;
        _btn_Open.selected = !_btn_Open.selected;
        _ctrl.hidden = !_ctrl.hidden;
        _currentCombobox = nil;
        
    }
}

//加载模糊视图，展开下拉列表事加载。
-(void)initDimControl
{
    _ctrl=[[UIControl alloc]initWithFrame:self.superview.bounds];
    _ctrl.hidden=NO;
    //[_ctrl setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    [_ctrl setBackgroundColor:[UIColor clearColor]];
    [_ctrl addTarget:self action:@selector(controlAction) forControlEvents:UIControlEventTouchUpInside];
    //[self.superview insertSubview:_ctrl belowSubview:self];
    [self.superview addSubview:_ctrl];
    [self.superview bringSubviewToFront:self];
}



#pragma mark - Private Methods
//点击模糊视图是调用
-(void)controlAction
{
    _currentCombobox.comboboxTabel.hidden = YES;
    _ctrl.hidden = YES;
}

#pragma mark - Public Methods

-(UITableViewCell *)comboboxcellforRow:(NSInteger)row
{
    
    NSIndexPath *indexpath  = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell   = [self.comboboxTabel cellForRowAtIndexPath:indexpath];
    return cell;
}

#pragma mark - UITableView Delagate

//请求下拉列表行数，由调用者实现代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate numberOfRowsInComboboxView];
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
    cell.textLabel.text = [self.delegate comboboxView:self contentforRow:indexPath.row];

    return cell;
}

//选择某行后的反应，由调用者实现代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate comboboxView:self didselectRow:indexPath.row];
}
@end
