//
//  Demo1ViewController.m
//  JWCalendarExample
//
//  Created by administrator on 13/02/2017.
//  Copyright © 2017 YANGWW. All rights reserved.
//

#import "Demo1ViewController.h"
#import "JWCalendar.h"

@interface Demo1ViewController ()<JWCalendarDelegate>

@property (weak, nonatomic) IBOutlet JWCalendar *calendar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeigthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timezone;
@property (weak, nonatomic) IBOutlet UILabel *timezoneid;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *currentSelectedDate;


@property (strong,nonatomic) NSDateFormatter *format;

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"默认";
    self.currentSelectedDate.text = nil;
    
    self.calendar.delegate = self;
    
    _format = [[NSDateFormatter alloc] init];
    [_format setDateFormat:@"yyyy-MM-dd"];
    
    // 配置其它选项
//    JWCalendarConfig *config = self.calendar.otherConfig;
//    config.weekFontColor = [UIColor redColor];
    
    NSInteger dayNumberInWeek = [[NSDate date] weeklyOrdinality];
    NSLog(@"---:%ld",(long)dayNumberInWeek);
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统时区
    self.timezone.text = zone.abbreviation;
    self.timezoneid.text = zone.name;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentDate.text = [format stringFromDate:[NSDate date]];
}

- (IBAction)refreshCalendar:(UIButton *)sender {
    
//    setNeedsLayout和setNeedsDisplay
    
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
}

// 变更标记
- (IBAction)changeMarketButton:(id)sender {
    
    [self.calendar refreshMarketData];
}

// 上一月
- (IBAction)preMonth:(id)sender {
    
    [self.calendar previousMonth];
}

// 下一月
- (IBAction)nextMonth:(id)sender {
    [self.calendar nextMonth];
}

// 回到今天
- (IBAction)jumpToday:(id)sender {
    [self.calendar jumpToTotay];
}


#pragma mark JWCalendar delegate

// 日历中显示的月发生变化时调用
-(void)calendarMonthChanged:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth{

    self.dateLabel.text = [_format stringFromDate:date];
   
    self.calendarHeigthConstraint.constant = calendarHeigth;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

// 点击日历中的某一天时调用
-(void)calendar:(JWCalendar *)calendar didSelectDate:(NSDate *)date{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentSelectedDate.text = [format stringFromDate:date];
}

// 数据源，获取日历中需要标记的天
-(void)calendar:(JWCalendar *)calendar monthView:(MonthView *)monthView{
    
    // 在此处，可以通过接口获取需要标记的日期，然后重新设置标记日期
    
    
    /// 重新设置标记的日期
    monthView.needMarketDate = [NSMutableSet setWithObjects:@"2017-01-20",@"2017-01-10",@"2017-02-09",@"2017-02-22",@"2016-12-10", nil];
    
    
}



@end
