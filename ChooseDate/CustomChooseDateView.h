//
//  CustomChooseDateView.h
//  linggongzi
//
//  Created by 许启强 on 14-10-12.
//  Copyright (c) 2014年 jinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomComboboxView.h"
#import "UIViewExt.h"

//用于tag，方便调用者判读
#define kSTARTYEAR  101
#define kSTARTMONTH 102
#define kSTOPYEAR   103
#define kSTOPMONTH  104
@class CustomChooseDateView;
@protocol CustomChooseDateDelegate <NSObject>

@optional
/**
 *  代理方法，点击累计时调用
 *
 *  @param chooseDateView 整个选择日期视图对象
 */
-(void)didCliclCalculateInChooseDateView:(CustomChooseDateView *)chooseDateView;

@end

@interface CustomChooseDateView : UIView<UITextFieldDelegate>

@property (strong,nonatomic)CustomComboboxView *startYear;
@property (strong,nonatomic)CustomComboboxView *startMonth;
@property (strong,nonatomic)CustomComboboxView *stopYear;
@property (strong,nonatomic)CustomComboboxView *stopMonth;

@property (strong,nonatomic)CustomComboboxView  *currentCombobox;

@property (strong,nonatomic)UIControl   *dimControl;

@property id<UIComboboxDelegate,CustomChooseDateDelegate>delegate;

/**
 *  init方法
 *
 *  @param frame    选择日期视图的Frame
 *  @param delegate 代理，要求实现UIComboboxDelegate,CustomChooseDateDelegate两个代理
 *
 *  @return 选择日期视图对象
 */
-(CustomChooseDateView *)initWithFrame:(CGRect)frame AndDelegae:(id<UIComboboxDelegate,CustomChooseDateDelegate>)delegate;

@end
