//
//  DateModel.h
//  CustomCalender
//
//  Created by 许启强 on 14-10-16.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
//    STATENONE          = 0,
    STATEPREVIOUDMONTH = 1,
    STATECURRENTMOTNH  = 2,
    STATENEXTMONTH     = 3,
} customDayState;

@interface DateModel : NSObject

@property   customDayState state;
@property   NSInteger day;

@end
