//
//  Combox.h
//
//
//  Created by 许启强 on 14-10-10.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

/*
 *  自定义下拉列表 CustomComboxView
 *  版本 1。0
 *  环境 xcode 6.0.1,IOS SDK 8.0,iPhone 6
 *  作者 许启强 myqiqiang@gmail.com
 *
 *  调用者必须实现UIComboxDelegate协议
 *  图片颜色等没有暂时没有接口，可以自己实现
 *  2014-10-11
 */

#import <UIKit/UIKit.h>

@class CustomComboxView;

@protocol UIComboxDelegate <NSObject>

@required
/*
 *  -(NSInteger)numberOfRowsInCombox 请求下拉列表行数，初始化下拉表时调用，必须实现
 *
 *  -(NSString *)Combox:(CustomComboxView *)combox contentforRow:(NSInteger )row 
 *  请求下拉列表中某一行的内容，当这一行出现时调用
 *  @参数combox   操作的下拉表视图CustomComboxView
 *  @参数row      请求内容的行数
 *
 *  -(void)Combox:(CustomComboxView *)combox didselectRow:(NSInteger )row
 *  选择下拉列表中的某一行时调用，选择实现
 *  @参数combox   操作的下拉表视图CustomComboxView
 *  @参数row      选中的行数
 */
-(NSInteger)numberOfRowsInCombox;
-(NSString *)Combox:(CustomComboxView *)combox contentforRow:(NSInteger )row;
@optional
-(void)Combox:(CustomComboxView *)combox didselectRow:(NSInteger )row;

@end

@interface CustomComboxView : UIView<UITableViewDelegate,UITableViewDataSource>

/*
 *  @变量 lab_Input输入框，显示值
 *  @变量 btn_Open展开下拉表按钮
 *  @变量 comboxTabel下拉表，类型为tabelview
 */

@property (strong,nonatomic)UILabel     *lab_Input;
@property (strong,nonatomic)UIButton    *btn_Open;
@property (strong,nonatomic)UITableView *comboxTabel;

@property BOOL isOn;

//调用它的类负责实现代理方法
@property id<UIComboxDelegate>delegate;

@end
