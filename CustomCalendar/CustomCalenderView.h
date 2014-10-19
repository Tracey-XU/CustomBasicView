//
//  MonthTableView.h
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateModel.h"
#import "MonthTableCollectionViewCell.h"

@class CustomCalenderView;

@protocol CustomCalenderViewDelegate <NSObject>

@optional
/**
 *  选择日期
 *
 *  @param calendar  日历
 *  @param indexPath 所在indexpath
 */
-(void)calendar:(CustomCalenderView *)calendar didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomCalenderView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    @private
    NSArray *_arr_Week; //星期
}


@property   NSMutableArray *arr_MonthData;  //月数据

@property   NSInteger totalRows;            //月历行数

@property   id<CustomCalenderViewDelegate>delegate;

/**
 *  返回选中的日期
 *
 *  @return NSDate对象，只保证年月日
 */
-(NSDate *)getSelectDate;

/**
 *  返回今天的日期
 *
 *  @return NSDate对象，只保证年月日
 */
-(NSDate *)getCurrenteDate;


/**
 *  返回当前选中的cell
 *
 *  @return 返回选中的整个cell
 */
-(MonthTableCollectionViewCell *)getSelectCell;

@end
