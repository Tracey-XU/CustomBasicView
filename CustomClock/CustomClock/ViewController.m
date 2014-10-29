//
//  ViewController.m
//  CustomClock
//
//  Created by 许启强 on 14/10/29.
//  Copyright (c) 2014年 nyqiqiang. All rights reserved.
//

#import "ViewController.h"
#import "CustomClockView.h"

@interface ViewController ()
{
    CustomClockView *_clockView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _clockView = [[CustomClockView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    _clockView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_clockView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
