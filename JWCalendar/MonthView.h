
//
//  MonthView.h
//  JWTest
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCalendarConfig.h"
#import "DayView.h"

@protocol MonthViewDelegate <NSObject>

/// 点击日历中的天时调用
-(void)monthViewClickWithDate:(NSDate *)date;


/// 设置日期时调用；可用于重写或更新DayView的显示外观
-(void)dayViewSetDateWithDayView:(DayView *)dayView status:(JWDayViewStatus)dayStatus dayLabel:(UILabel *)dayLabel;

@end

@interface MonthView : UICollectionViewCell


/// 需要标记的日期,日期格式必须为：yyyy-MM-dd; 被标记的日期会被特殊显示;
@property (weak,nonatomic) NSMutableSet<NSString *> *needMarketDate;

/// 今天
@property (strong,nonatomic,readonly) NSDate *today;

/// 此view所表示的日期(月)
@property (strong,nonatomic) NSDate *date;



#pragma mark 控件内部使用

/// 此view根据要显示的日期计算出的高度
@property (assign,nonatomic) CGFloat monthViewHeigth;

/// 配置
@property (weak,nonatomic) JWCalendarConfig *config;

@property (weak,nonatomic) id<MonthViewDelegate>delegate;

@end


