//
//  WeekCalendar.h
//  Quick_start
//
//  Created by administrator on 29/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

/// 周日历

#import <UIKit/UIKit.h>

#import "JWCalendarConfig.h"
#import "WeekView.h"

@class WeekCalendar;

@protocol WeekCalendarDelegate <NSObject>

/// 滑动日历，减速停止后调用
-(void)weekCalendarEndDecelerating:(WeekCalendar *)calendar todayOrStartDate:(NSDate *)date;

/// 点击选中某一天时调用
-(void)weekCalendar:(WeekCalendar *)weekCalendar didSelectDate:(NSDate *)date;

@end

@interface WeekCalendar : UIView

@property (weak,nonatomic) JWCalendarConfig *config;

/// 当前周日历页的第一天
@property (strong,nonatomic) NSDate *startDate;

/// 需要标记的日期,日期格式必须为：yyyy-MM-dd; 被标记的日期会被特殊显示;
@property (strong,nonatomic) NSMutableSet<NSString *> *needMarketDate;

@property (weak,nonatomic) id<WeekCalendarDelegate> delegate;

@end
