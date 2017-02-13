//
//  Demo2ViewController.m
//  JWCalendarExample
//
//  Created by administrator on 13/02/2017.
//  Copyright © 2017 YANGWW. All rights reserved.
//

#import "Demo2ViewController.h"
#import "JWCalendar.h"

@interface Demo2ViewController ()<UIScrollViewDelegate,JWCalendarDelegate>

@property (weak, nonatomic) IBOutlet JWCalendar *calendar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeigthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendar.delegate = self;
    
    self.title = @"钉住日历";
    
    // 钉住周
    self.calendar.weekBarFollowSlide = NO;
    
    self.calendar.delegate = self;
    
    // 配置其它选项
    //    JWCalendarConfig *config = self.calendar.otherConfig;
    //    config.weekFontColor = [UIColor redColor];
    
    
//    [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight | UIRectEdgeTop];

    NSLog(@"%lu",self.edgesForExtendedLayout & 1);
}

- (IBAction)changeMarketButton:(id)sender {
    
    [self.calendar refreshMarketData];
    
}

- (IBAction)preMonth:(id)sender {
    
    [self.calendar previousMonth];
    
}

- (IBAction)nextMonth:(id)sender {
    [self.calendar nextMonth];
}

- (IBAction)jumpToday:(id)sender {
    [self.calendar jumpToTotay];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    NSLog(@"will:%f",scrollView.contentOffset.y);

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.calendar slideWithScrollView:scrollView];
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self.calendar slideWidthWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    
}


#pragma mark JWCalendar delegate

// 日历中显示的月发生变化时调用
-(void)calendarMonthChanged:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    self.dateLabel.text = [format stringFromDate:date];
    
    self.calendarHeigthConstraint.constant = calendarHeigth;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

// 点击日历中的某一天时调用
-(void)calendar:(JWCalendar *)calendar didSelectDate:(NSDate *)date{
    
    NSLog(@"selected:%@",date);
    
}

// 数据源，获取日历中需要标记的天
-(void)calendar:(JWCalendar *)calendar monthView:(MonthView *)monthView{
    
    // 在此处，可以通过接口获取需要标记的日期，然后重新设置标记日期
    
    /// 重新设置标记的日期
    monthView.needMarketDate = [NSMutableSet setWithObjects:@"2017-01-20",@"2017-01-10",@"2017-02-09",@"2017-02-22",@"2016-12-10", nil];
    
}



@end
