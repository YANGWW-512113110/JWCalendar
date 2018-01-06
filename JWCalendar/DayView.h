//
//  DayView.h
//  JWTest
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCalendarConfig.h"
#import "JWCategory.h"


@class DayView;

/// DayView状态
typedef enum : NSUInteger {
    JWDayViewStatus_normal,       // 正常状态
    JWDayViewStatus_disable,      // 禁用状态
    JWDayViewStatus_selected,     // 选中状态
    JWDayViewStatus_mark,         // 正常状态下被标记
    JWDayViewStatus_mark_weekend, // 周末被标记
    JWDayViewStatus_mark_today,   // 今天被标记
    JWDayViewStatus_mark_today_weekend,  // 今天为周末，且被标记
    
    JWDayViewStatus_disable_selected_today, // 禁用状态下今天被选中
    JWDayViewStatus_selected_today,         // 选中状态下的今天
    JWDayViewStatus_today,                  // 正常状态下的今天
    JWDayViewStatus_disable_today,          // 禁用状态下的今天
    JWDayViewStatus_today_weekend,          // 今天为周末
    JWDayViewStatus_disable_today_weekend   // 禁用状态下的今天为周末
    
} JWDayViewStatus;

@protocol DayViewDelegat<NSObject>

/**
 *  点击DayView时调用
 */
-(void)dayViewWithClick:(DayView *)dayView;


/**
 *  设置日期时调用；可用于重写或更新DayView的显示外观
 */
-(void)dayViewSetDateWithDayView:(DayView *)dayView status:(JWDayViewStatus)dayStatus dayLabel:(UILabel *)dayLabel;

@end

@interface DayView : UIView


@property (weak,nonatomic) JWCalendarConfig *config;

/// 此DayView所在的月；为0时不区分所在月
@property (assign,nonatomic) NSInteger dateMonth;

/// 此DayView所表示的日期
@property (strong,nonatomic) NSDate *date;

/// 是否被标记
@property (assign,nonatomic) BOOL isMarkedDay;

@property (weak,nonatomic) id<DayViewDelegat>delegate;

/// 是否为今天
@property (assign,nonatomic,readonly) BOOL isToday;

/// 是否为当前月
@property (assign,nonatomic,readonly) BOOL isCurrentMonth;

/// 标记并设置日期；若参数date为空，则成员变量date必须不能为空，否则将标记失败
- (void)markedDayAndSetDate:(NSDate *)date;

/// 取消标记
-(void)cancelMarked;

@end
