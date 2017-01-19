//
//  NSDate+JW.h
//  ErTong
//
//  Created by administrator on 16/10/20.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JW)

/// 获取当前时间，以系统时区为准
+ (NSDate *)currentDate;

/// 转换日期时间到当前系统时区
- (NSDate *)convertToCurrentTimeZone;

/// 获取时间戳（本地时区）, 如：2016-12-28 13:26:32:22
+ (NSString *)timestamp_local;

/// 获取时间戳,1970距今的毫秒数
+ (NSTimeInterval)timestamp;



/**
 *  获取当前月的天数
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取当前周的第一天
 */
- (NSDate *)firstDayOfCurrentWeek;
    
/**
 *  获取当前月的第一天
 */
- (NSDate *)firstDayOfCurrentMonth;

/**
 *  获取当前时间点处于本周的第几天(1:周日，2:周一，3:周二，4:周三，5:周四，6:周五，7:周六)
 */
- (NSUInteger)weeklyOrdinality;

/**
 *  获取当前月在日历中的行数
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**
 *  转换时间转至系统时区对应的时间
 */
+ (NSDate *)convertDateToSystemZone:(NSDate *)date;


/**
 *  在当前日期的基础上增加上指定天数
 *
 *  @param dayNumber 欲加的天数
 */
- (NSDate *)additionDay:(NSInteger)dayNumber;

/**
 *  在当前月的基础上增加上指定月数
 *
 *  @param monthNumber 欲添加的月数
 */
-(NSDate *)additionMonth:(NSInteger)monthNumber;
    
@end
