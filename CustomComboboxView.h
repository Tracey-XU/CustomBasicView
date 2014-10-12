//
//  CustomComboboxView.h
//
//
//  Created by 许启强 on 14-10-10.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

/*
 *  自定义下拉列表 CustomComboboxView
 *  版本 1。0
 *  环境 xcode 6.0.1,IOS SDK 8.0,iPhone 6
 *  作者 许启强 myqiqiang@gmail.com
 *
 *  调用者必须实现UIComboboxDelegate协议
 *  图片颜色等没有暂时没有接口，可以自己实现
 *  2014-10-11
 *
 *  修改视图名字
 *  修改代理方法名字
 *  
 *  添加-(UITableViewCell *)comboboxcellforRow:(NSInteger)row;fangfa
 *
 *  添加模糊视图属性
 *  添加detailLabel属性
 *  添加currentCombox属性
 */

#import <UIKit/UIKit.h>

@class CustomComboboxView;

@protocol UIComboboxDelegate <NSObject>

@required
/*
 *  -(NSInteger)numberOfRowsInCombobox 请求下拉列表行数，初始化下拉表时调用，必须实现
 *
 *  -(NSString *)Combobox:(CustomComboboxView *)Combobox contentforRow:(NSInteger )row 
 *  请求下拉列表中某一行的内容，当这一行出现时调用
 *  @参数Combobox   操作的下拉表视图CustomComboboxView
 *  @参数row      请求内容的行数
 *
 *  -(void)Combobox:(CustomComboboxView *)Combobox didselectRow:(NSInteger )row
 *  选择下拉列表中的某一行时调用，选择实现
 *  @参数Combobox   操作的下拉表视图CustomComboboxView
 *  @参数row      选中的行数
 */
-(NSInteger)numberOfRowsInComboboxView;
-(NSString *)comboboxView:(CustomComboboxView *)combobox contentforRow:(NSInteger )row;
@optional
-(void)comboboxView:(CustomComboboxView *)combobox didselectRow:(NSInteger )row;
-(void)hideComboboxTable;
@end

@interface CustomComboboxView : UIView<UITableViewDelegate,UITableViewDataSource>

/*
 *  @变量 lab_Input输入框，显示值
 *  @变量 btn_Open展开下拉表按钮
 *  @变量 ComboboxTabel下拉表，类型为tabelview
 *  @变量 lab_Detail右边单位标签
 *  @变量 ctrl模糊视图
 *  @变量 currentCombox当前展开的下拉表
 */

@property (strong,nonatomic)UILabel     *lab_Input;
@property (strong,nonatomic)UILabel     *lab_Detail;
@property (strong,nonatomic)UIButton    *btn_Open;
@property (strong,nonatomic)UITableView *comboboxTabel;
@property (strong,nonatomic)UIControl   *ctrl;

@property (strong,nonatomic)CustomComboboxView  *currentCombobox;

//调用它的类负责实现代理方法
@property id<UIComboboxDelegate>delegate;

-(UITableViewCell *)comboboxcellforRow:(NSInteger)row;
@end
