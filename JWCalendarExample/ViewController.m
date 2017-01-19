//
//  ViewController.m
//  JWCalendarExample
//
//  Created by administrator on 18/01/2017.
//  Copyright © 2017 YANGWW. All rights reserved.
//

#import "ViewController.h"
#import "JWCalendar.h"

@interface ViewController ()<UIScrollViewDelegate,JWCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet JWCalendar *calendar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeigthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendar.delegate = self;
    
//    self.calendar.weekBarFollowSlide = NO;
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (IBAction)sureButton:(id)sender {
    
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


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.calendar slideWithScrollView:scrollView];
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self.calendar slideWidthWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    
}

-(void)calendarEndDecelerating:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
//    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    [format setTimeZone:GTMzone];
    self.dateLabel.text = [format stringFromDate:date];
    
    self.calendarHeigthConstraint.constant = calendarHeigth;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

-(void)calendar:(JWCalendar *)calendar didSelectDate:(NSDate *)date{
    
    NSLog(@"selected:%@",date);
    
}


-(void)calendar:(JWCalendar *)calendar monthView:(MonthView *)monthView{

    
    // 在此处赋值要标记的日期
    
    
    
    
    /// 重新设置标记的日期
    monthView.needMarketDate = [NSMutableSet setWithObjects:@"2017-01-20",@"2017-01-10",@"2017-02-09",@"2017-02-22",@"2016-12-10", nil];


}



@end
