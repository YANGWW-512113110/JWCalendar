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
    JWDayViewStatus_normal,
    JWDayViewStatus_disable,
    JWDayViewStatus_selected,
    JWDayViewStatus_mark,
    JWDayViewStatus_mark_weekend,
    JWDayViewStatus_mark_today,
    JWDayViewStatus_mark_today_weekend
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
