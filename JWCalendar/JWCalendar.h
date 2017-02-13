//
//  JWCalendar.h
//  Quick_start
//
//  Created by administrator on 28/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWCalendarConfig.h"
#import "JWCategory.h"

#import "WeekBarView.h"
#import "MonthView.h"
#import "WeekCalendar.h"

@class JWCalendar;

@protocol JWCalendarDelegate <NSObject>

/// 点击选中某一天时调用
-(void)calendar:(JWCalendar *)calendar didSelectDate:(NSDate *)date;


@optional

/// 当前显示的月数发生变化时调用；可用于获取当前月，以及显示当前月时日历控件所需要的高度；
-(void)calendarMonthChanged:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth;

/// 滑动日历，减速停止后调用
-(void)calendarEndDecelerating:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth  NS_DEPRECATED_IOS(0.01,0.06,"Implement calendarMonthChanged: currentMonth: calendarHeigth:instead");

/// 获取月日历中标记的日期,日期格式必须为：yyyy-MM-dd
-(void)calendar:(JWCalendar *)calendar monthView:(MonthView *)monthView;

@end

@interface JWCalendar : UIView


@property (weak,nonatomic) id<JWCalendarDelegate> delegate;


/// 回到今天
-(void)jumpToTotay;

/// 上个月
-(void)previousMonth;

/// 下个月
-(void)nextMonth;

/// 刷新标记数据,会触发calendar:monthView:方法被调用；
-(void)refreshMarketData;



#pragma mark 功能配置

/// 上下滑动时，周bar是否跟随滑动；默认不跟随。此选项只有当此控件处于UIScrollview、UITbleView中时才有效；
@property (assign,nonatomic) BOOL weekBarFollowSlide;

/// 若weekBarFollowSlide为YES,则需要在代理方法scrollViewDidScroll:中调用此方法
- (void)slideWithScrollView:(UIScrollView *)scrollView;

/// 若weekBarFollowSlide为YES,则需要在代理方法scrollViewWillEndDragging: withVelocity:targetContentOffset:中调用此方法
- (void)slideWidthWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;


#pragma mark 其它所有配置

/// 其它配置
@property (strong,nonatomic,readonly) JWCalendarConfig *otherConfig;





@end
