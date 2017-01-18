//
//  WeekView.h
//  Quick_start
//
//  Created by administrator on 29/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DayView.h"
#import "JWCalendarConfig.h"

@protocol WeekViewDelegate <NSObject>

/// 点击日历中的天时调用
-(void)weekViewClickWithDate:(NSDate *)date;

@end

@interface WeekView : UICollectionViewCell


@property (weak,nonatomic) JWCalendarConfig *config;


/// 起始时期
@property (strong,nonatomic) NSDate *startDate;

/// 今天
@property (strong,nonatomic,readonly) NSDate *today;

/// 需要标记的日期,日期格式必须为：yyyy-MM-dd
@property (weak,nonatomic) NSMutableSet<NSString *> *needMarketDate;

@property (weak,nonatomic) id<WeekViewDelegate> delegate;


@end
