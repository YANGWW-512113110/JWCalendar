//
//  ViewController.m
//  JWCalendarExample
//
//  Created by administrator on 18/01/2017.
//  Copyright © 2017 YANGWW. All rights reserved.
//

#import "ViewController.h"

#import "Demo1ViewController.h"
#import "Demo2ViewController.h"
#import "Demo3ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JWCalendar";
    
}

// 默认
- (IBAction)demo1:(id)sender {
    
    Demo1ViewController *d = [[Demo1ViewController alloc] init];
    [self.navigationController pushViewController:d animated:YES];
}

// 钉住日历
- (IBAction)demo2:(id)sender {
    
    Demo2ViewController *d = [[Demo2ViewController alloc] init];
    [self.navigationController pushViewController:d animated:YES];
}

// 自定义每一天
- (IBAction)demo3:(id)sender {
    
    Demo3ViewController *d = [[Demo3ViewController alloc] init];
    [self.navigationController pushViewController:d animated:YES];
}

@end
