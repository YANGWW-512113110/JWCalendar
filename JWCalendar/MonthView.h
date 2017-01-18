
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

@end

@interface MonthView : UICollectionViewCell

/// 此view根据要显示的日期计算的高度
@property (assign,nonatomic) CGFloat monthViewHeigth;

@property (weak,nonatomic) JWCalendarConfig *config;

/// 此view所表示的日期(月)
@property (strong,nonatomic) NSDate *date;

/// 需要标记的日期,日期格式必须为：yyyy-MM-dd
@property (weak,nonatomic) NSMutableSet<NSString *> *needMarketDate;

/// 保存日期对应的DayView;日期为key,其格式为:yyyy-MM-dd
@property (strong,nonatomic) NSMutableDictionary *dateAndDayView;

@property (strong,nonatomic) NSMutableArray<DayView *> *dayViewArray;

/// 今天
@property (strong,nonatomic,readonly) NSDate *today;

@property (weak,nonatomic) id<MonthViewDelegate>delegate;

@end


