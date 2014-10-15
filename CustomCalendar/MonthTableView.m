//
//  MonthTableView.m
//  CustomCalender
//
//  Created by 许启强 on 14-10-15.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "MonthTableView.h"
#import "MonthTableCollectionViewCell.h"

@implementation MonthTableView

static NSString *sCELLIDENTIFIER = @"cellidentifier";

#pragma mark - View Lifecycle

-(MonthTableView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _arr_Week = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六",];
        
        [self initSubView];
    }
    
    return self;
}

-(void)initSubView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;

    UICollectionView *col_Month = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10) collectionViewLayout:flowLayout];
    
    col_Month.dataSource = self;
    col_Month.delegate   = self;
    
    [self addSubview:col_Month];
    

    [col_Month registerClass:[MonthTableCollectionViewCell class] forCellWithReuseIdentifier:sCELLIDENTIFIER];
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
        return 5*7;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat width = collectionView.frame.size.width / 7;
    return CGSizeMake(width, width);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthTableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sCELLIDENTIFIER forIndexPath:indexPath];
    
    //Debug
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [cell.btn_Day setTitle:[NSString stringWithFormat:@"%@",_arr_Week[indexPath.row]] forState:UIControlStateNormal];
    }
    else
    {

    cell.btn_Day.backgroundColor = [UIColor whiteColor];
    [cell.btn_Day setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
    }
    
    return cell;
}




@end
