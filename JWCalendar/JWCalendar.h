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

/// 滑动日历，减速停止后调用
-(void)calendarEndDecelerating:(JWCalendar *)calendar currentMonth:(NSDate *)date calendarHeigth:(CGFloat)calendarHeigth;

/// 点击选中某一天时调用
-(void)calendar:(JWCalendar *)calendar didSelectDate:(NSDate *)date;

@end

@interface JWCalendar : UIView


@property (weak,nonatomic) id<JWCalendarDelegate> delegate;

/// 需要标记的日期,日期格式必须为：yyyy-MM-dd; 被标记的日期会被特殊显示;
@property (strong,nonatomic) NSMutableSet<NSString *> *needMarketDate;

/// 回到今天
-(void)jumpToTotay;

/// 上个月
-(void)previousMonth;

/// 下个月
-(void)nextMonth;



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
