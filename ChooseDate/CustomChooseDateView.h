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


@interface CustomChooseDateView : UIView<UITextFieldDelegate>

@property (strong,nonatomic)CustomComboboxView *startYear;
@property (strong,nonatomic)CustomComboboxView *startMonth;
@property (strong,nonatomic)CustomComboboxView *stopYear;
@property (strong,nonatomic)CustomComboboxView *stopMonth;
@property (strong,nonatomic)UIButton *btn_Calculate;
@property (strong,nonatomic)CustomComboboxView  *currentCombobox;

@property (strong,nonatomic)UIControl   *dimControl;

@property id<UIComboboxDelegate>delegate;

-(CustomChooseDateView *)initWithFrame:(CGRect)frame AndDelegae:(id<UIComboboxDelegate>)delegate;

@end
