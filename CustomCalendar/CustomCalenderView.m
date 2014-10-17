//
//  MonthTableView.m
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "CustomCalenderView.h"

@implementation CustomCalenderView
{
    UILabel  *_lab_Title;   //标题
    UIButton *_btn_Previous;   //上个月
    UIButton *_btn_Next;   //下个月
    UICollectionView *_col_Month;
    
    NSInteger _totalRows;
    
    NSInteger _currentYear;          //当天的年月日
    NSInteger _currentMonth;
    NSInteger _currentDay;
    
    NSInteger _selectYear;          //选中的年月日
    NSInteger _selectMonth;
    NSInteger _selectDay;
    
    NSInteger _displayYear;          //当前显示的年月
    NSInteger _displayMonth;
    
    BOOL      flag;             //显示的是否是当前月
    
    MonthTableCollectionViewCell *_selectedCell;
}

static NSString *sCELLIDENTIFIER = @"cellidentifier";

#pragma mark - View Lifecycle

-(CustomCalenderView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _arr_Week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六",];
        
        //加载头视图
        [self initHeaderView];
        
        //加载主体月历视图
        [self initMainBodyView];
        
        //获取当前月历
        flag = YES;
        [self getCurrentMonthTable];


    }
    return self;
}

//加载头视图
-(void)initHeaderView
{
    //上个月   高度为 日历视图的七分之一
    _btn_Previous = [UIButton buttonWithType:UIButtonTypeSystem];
    float heght = self.frame.size.width * 1/7;
    _btn_Previous.frame  =   CGRectMake(5,5,self.frame.size.width * 1/7, heght);
    [_btn_Previous addTarget:self action:@selector(previous_Onclick) forControlEvents:UIControlEventTouchUpInside];
    [_btn_Previous setTitle:@"◀︎" forState:UIControlStateNormal];
    [self addSubview:_btn_Previous];
    
    //标题   高度为 日历视图的七分之一
    _lab_Title  =   [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 1/7,0, self.frame.size.width * 5/7, _btn_Previous.frame.size.height)];
    _lab_Title.textAlignment =   NSTextAlignmentCenter;
    [self addSubview:_lab_Title];
    
    //为标题添加单击手势，单击回到今天
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCurrentMonthTable)];
    _lab_Title.userInteractionEnabled = YES;
    [_lab_Title addGestureRecognizer:tap];
    
    //下个月   高度为 日历视图的七分之一
    _btn_Next = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn_Next.frame  =   CGRectMake(self.frame.size.width * 6/7, 0,self.frame.size.width * 1/7, _btn_Previous.frame.size.height);
    [_btn_Next addTarget:self action:@selector(next_Onclick) forControlEvents:UIControlEventTouchUpInside];
    [_btn_Next setTitle:@"▶︎" forState:UIControlStateNormal];
    [self addSubview:_btn_Next];
}

//加载主体月历视图
-(void)initMainBodyView
{
    //设置月历，UICollectionView实现，设置为流布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0.1;
    flowLayout.minimumLineSpacing      = 2;

    _col_Month = [[UICollectionView alloc]initWithFrame:CGRectMake(5, self.frame.size.width * 1/7, self.frame.size.width - 10, self.frame.size.width) collectionViewLayout:flowLayout];
    
    _col_Month.dataSource = self;
    _col_Month.delegate   = self;
    
    [self addSubview:_col_Month];
    
    //注册cell
    [_col_Month registerClass:[MonthTableCollectionViewCell class] forCellWithReuseIdentifier:sCELLIDENTIFIER];
    
    //设置颜色
    _col_Month.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

#pragma mark - UICollectionView Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }
    else {
        return [_arr_MonthData count];
    }
}

//设置item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    CGFloat width;

    width = collectionView.frame.size.width / 7 - 2;
    
    return CGSizeMake(width, width);
    

}

//设置cell内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sCELLIDENTIFIER forIndexPath:indexPath];

    if (indexPath.section == 0) {
        cell.userInteractionEnabled = NO;
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [cell.btn_Day setTitle:[NSString stringWithFormat:@"%@",_arr_Week[indexPath.row]] forState:UIControlStateNormal];
    }
    else
    {
        cell.btn_Day.userInteractionEnabled = NO;
        cell.dateModel = _arr_MonthData[indexPath.row];
        if (_displayMonth == _currentMonth) {
            if (cell.dateModel.day == _currentDay) {
                cell.backgroundColor = [UIColor orangeColor];
            }
        }
    }
    
    return cell;
}

//点击某个cell后调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthTableCollectionViewCell *cell = (MonthTableCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
     if (cell.dateModel.state == STATEPREVIOUDMONTH) {    //上个月，更新月历
        if (_currentMonth == 1) {
            [self updateMonthTableWithYear:_currentYear - 1 AndMonth:12];
        }else {
            [self updateMonthTableWithYear:_currentYear AndMonth:_currentMonth - 1];
            [UIView animateWithDuration:1
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:NO];
                             }
                             completion:^(BOOL finished) {
                             }];
        }
    } else if (cell.dateModel.state == STATENEXTMONTH) {    //下个月，更新月历
        if (_currentMonth == 12) {
            [self updateMonthTableWithYear:_currentYear+1 AndMonth:1];
        } else {
            [self updateMonthTableWithYear:_currentYear AndMonth:_currentMonth+1];
        }
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO];
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    
    //颜色设置之后，调用代理方法
    [self.delegate calendar:self didSelectItemAtIndexPath:indexPath];
    
        self.selectedCell = cell;
    
}
#pragma mark - Action Methods

//上个月，更新月历
-(void)previous_Onclick
{
    if (_displayMonth == 1) {
        [self updateMonthTableWithYear:_displayYear - 1 AndMonth:12];
    }
    else {
        [self updateMonthTableWithYear:_displayYear AndMonth:_displayMonth - 1];
    }
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:NO];
                     }
                     completion:^(BOOL finished) {
                     }];
}

//下个月，更新月历
-(void)next_Onclick
{
    if (_displayMonth == 12) {
        [self updateMonthTableWithYear:_displayYear + 1 AndMonth:1];
    }
    else {
        [self updateMonthTableWithYear:_displayYear AndMonth:_displayMonth + 1];
    }
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO];
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark - Month Table Methods

//初始化时加载当前月份
-(void)getCurrentMonthTable
{
    NSDate *date = [NSDate date];
    NSCalendar  *greCarlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [greCarlendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];

    //更新今天的值
    _currentDay   = dateCompoment.day;
    _currentMonth = dateCompoment.month;
    _currentYear  = dateCompoment.year;
    
    if (_displayMonth && ( _displayMonth != _currentMonth || _displayYear != _currentYear )) {
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO];
                         }
                         completion:^(BOOL finished) {
                         }];
    }
    [self updateMonthTableWithYear:_currentYear AndMonth:_currentMonth];
    

}

-(void)updateMonthTableWithYear:(NSInteger)year AndMonth:(NSInteger)month
{
    //更新年月
    _displayYear  = year;
    _displayMonth = month;
    
    //每次更新月历，标题设置为1号，点击标题回到当前时间,当前月则显示今天日期
    if (_displayYear == _currentYear && _displayMonth == _currentMonth) {
        _lab_Title.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)_currentYear,(long)_currentMonth,(long)_currentDay];
    }
    else {
        _lab_Title.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)year,(long)month,(long)1];
    }
    
    //构造NSDateComponents，设置年月日
    NSCalendar  *carlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [[NSDateComponents alloc]init];
    dateCompoment.year  = year;
    dateCompoment.month = month;
    dateCompoment.day   = 1;
    NSDate *date = [carlendar dateFromComponents:dateCompoment];
    
    //该月第一天
    NSInteger weekOfFirstDay = [self getWeekWithDate:date];
    NSInteger j = weekOfFirstDay;
    
    //求得月历有几行
    if ( ([self getTotalDayInMonth:month AndYear:year] + j -1 )%7) {
        _totalRows = ([self getTotalDayInMonth:month AndYear:year] + j -1 )/7 + 1;
    }
    else
        _totalRows = _totalRows = ([self getTotalDayInMonth:month AndYear:year] + j -1 )/7;
    
    _arr_MonthData = [[NSMutableArray alloc]init];
    
    //上个月的日期
    for (NSInteger i = [self getTotalDayInMonth:month - 1 AndYear:year] - j + 2; j > 1; j--,i++) {
        
        DateModel *date = [[DateModel alloc]init];
        date.state = STATEPREVIOUDMONTH;
        date.day   = i;
        
        [_arr_MonthData addObject:date];
    }
    
    //当前月的日期
    for (NSInteger i = 1; i <= [self getTotalDayInMonth:month AndYear:year]; i++) {
        
        DateModel *date = [[DateModel alloc]init];
        date.state = STATECURRENTMOTNH;
        date.day   = i;
        
        [_arr_MonthData addObject:date];
    }
    
    //下个月的日期
    NSInteger max = _totalRows*7 - [_arr_MonthData count];
    for (NSInteger i = 1; i <= max; i++) {
        
        DateModel *date = [[DateModel alloc]init];
        date.state = STATENEXTMONTH;
        date.day   = i;
        
        [_arr_MonthData addObject:date];
    }
    
    [_col_Month reloadData];
}

-(void)setSelectedCell:(MonthTableCollectionViewCell *)selectedCell
{
    _selectedCell.backgroundColor = [UIColor whiteColor];
    
    _selectedCell = selectedCell;
    
    if (_displayMonth != _currentMonth) {
        _selectedCell.backgroundColor = [UIColor grayColor];
    }
     else if (_selectedCell.dateModel.day != _currentDay) {
        _selectedCell.backgroundColor = [UIColor grayColor];
    }
}
#pragma mark - Calculate Date Methods

//是否为闰年
-(BOOL)isLeapYear:(NSInteger)year
{
    return ( (! year&400) || ( (! year%4) && (year %100) ) );
}

//一个月有几天
-(NSInteger)getTotalDayInMonth:(NSInteger)month AndYear:(NSInteger)year
{
    if ( (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) ) {
        return 31;
    } else  if (month == 2){
        if ([self isLeapYear:year]) {
            return 29;
        }else
            return 28;
    } else {
        return 30;
    }
}

//某一天是星期几
-(NSInteger)getWeekWithDate:(NSDate *)date
{
    NSCalendar  *greCarlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [greCarlendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday| NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekdayOrdinal fromDate:date];
    
    return dateCompoment.weekday;
    
}

#pragma mark - Public Methods
-(NSDate *)getSelectDate
{
    //构造NSDateComponents，设置年月日
    NSCalendar  *carlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [[NSDateComponents alloc]init];
    dateCompoment.year  = _currentYear;
    dateCompoment.month = _currentMonth;
    dateCompoment.day   = _currentDay;
    NSDate *date = [carlendar dateFromComponents:dateCompoment];
    return date;
}

-(NSDate *)getCurrenteDate
{
    NSCalendar  *carlendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompoment = [[NSDateComponents alloc]init];
    dateCompoment.year  = _currentYear;
    dateCompoment.month = _currentMonth;
    dateCompoment.day   = _currentDay;
    NSDate *date = [carlendar dateFromComponents:dateCompoment];
    
    return date;
}

-(MonthTableCollectionViewCell *)getSelectCell
{
    return _selectedCell;
}
@end
