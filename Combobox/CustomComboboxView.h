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
 *  添加-(UITableViewCell *)comboboxcellforRow:(NSInteger)row方法
 *  添加-(void)ComboboxTableChangedidhidden:(CustomComboboxView *)combobox方法
 *
 *  添加detailLabel属性
 */

#import <UIKit/UIKit.h>

@class CustomComboboxView;

@protocol UIComboboxDelegate <NSObject>

@required
/*
 *  -(NSInteger)numberOfRowsInCombobox
 *
 *  -(NSString *)Combobox:(CustomComboboxView *)Combobox contentforRow:(NSInteger )row 
 *
 *  @参数Combobox   操作的下拉表视图CustomComboboxView
 *  @参数row
 *
 *  -(void)Combobox:(CustomComboboxView *)Combobox didselectRow:(NSInteger )row
 *
 *  @参数Combobox   操作的下拉表视图CustomComboboxView
 *  @参数row      选中的行数
 */
/**
 *  请求下拉列表行数，初始化下拉表时调用，必须实现
 *
 *  @param combobox
 *
 *  @return 请求内容的行数
 */
-(NSInteger)numberOfRowsInComboboxView:(CustomComboboxView *)combobox;
/**
 *  请求下拉列表中某一行的内容，当这一行出现时调用
 *
 *  @param combobox 请求的下拉列表对象
 *  @param row      请求内容的行数
 *
 *  @return 请求的内容
 */
-(NSString *)comboboxView:(CustomComboboxView *)combobox contentforRow:(NSInteger )row;
@optional
/**
 *  代理方法，选择下拉列表中的某一行时调用，选择实现
 *
 *  @param combobox 点击的下拉列表对象
 *  @param row      选择的行数
 */
-(void)comboboxView:(CustomComboboxView *)combobox didselectRow:(NSInteger )row;
/**
 *  代理方法，下拉列表hidden属性改变时调用，选择实现
 *
 *  @param combobox 改变的下拉列表
 */
-(void)ComboboxTableChangedidhidden:(CustomComboboxView *)combobox;
@end

@interface CustomComboboxView : UIView<UITableViewDelegate,UITableViewDataSource>

/*
 *  @变量 lab_Input输入框，显示值
 *  @变量 btn_Open展开下拉表按钮
 *  @变量 ComboboxTabel下拉表，类型为tabelview
 *  @变量 lab_Detail右边单位标签
 */

@property (strong,nonatomic)UILabel     *lab_Input;
@property (strong,nonatomic)UILabel     *lab_Detail;
@property (strong,nonatomic)UIButton    *btn_Open;
@property (strong,nonatomic)UITableView *comboboxTabel;


//调用它的类负责实现代理方法
@property id<UIComboboxDelegate>delegate;

/**
 *  通过行数获取cell
 *
 *  @param row 行数
 *
 *  @return row对应的行，类型为UITableViewCell
 */
-(UITableViewCell *)comboboxcellforRow:(NSInteger)row;
@end
