//
//  NSDate+JW.m
//  ErTong
//
//  Created by administrator on 16/10/20.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "NSDate+JW.h"

@implementation NSDate (JW)

+(NSDate *)currentDate{
    
    
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统时区
    
    // 以秒为单位返回当前时间与系统格林尼治时间的差
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    return dateNow;
    
}

- (NSDate *)convertToCurrentTimeZone{

    // 设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    
    // 设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    // 得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    
    // 目标日期与本地时区的偏移量    
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    
    // 得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    // 转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    
    return destinationDateNow;

}

/// 获取时间戳,如：2016-12-28 13:26:32:22
+(NSString *)timestamp_local{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    
    return timeLocal;
}

+(NSTimeInterval)timestamp{

    // timeIntervalSince1970返回与1970-1-1 0:0:0的相隔秒数，乘1000获取毫秒数；
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    
    return interval;
}


- (NSUInteger)numberOfDaysInCurrentMonth{
    
    /*
     + (id)currentCalendar / + (id)autoupdatingCurrentCalendar
     这两个类方法都将返回当前客户端的逻辑日历，区别在于：currentCalendar取得的值会一直保持在cache中，第一次用此方法实例化对象后，即使修改了系统日历设定，这个对象也不会改变。而使用autoupdatingCurrentCalendar，当每次修改系统日历设定，其实例化的对象也会随之改变
     */
    
    
    /*
     根据参数提供的时间点，得到一个小单位在一个大的单位里面的取值范围(此处应用：天在月中的范围);
     */
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    
}

- (NSDate *)firstDayOfCurrentWeek{
    
    /*
     根据参数提供的时间点，返回所在日历单位的开始时间。如果startDate和interval均可以计算，则返回YES；否则返回NO（此处应用：获取当前时间点对应的月的开始时间）
     
     unit -- 日历单位
     datep -- 开始时间，通过参数返回
     tip -- 日历单位所对应的秒数，通过参数返回；如果是月，则可能返回：2678400 = 31天 * 24小时 * 60分 * 60秒
     date -- 时间点参数
     */
    
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startDate interval:NULL forDate:self];
    
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    
    return startDate;
//    return [NSDate convertDateToSystemZone:startDate];
}


- (NSDate *)firstDayOfCurrentMonth{
    
    /*
     根据参数提供的时间点，返回所在日历单位的开始时间。如果startDate和interval均可以计算，则返回YES；否则返回NO（此处应用：获取当前时间点对应的月的开始时间）
     
     unit -- 日历单位
     datep -- 开始时间，通过参数返回
     tip -- 日历单位所对应的秒数，通过参数返回；如果是月，则可能返回：2678400 = 31天 * 24小时 * 60分 * 60秒
     date -- 时间点参数
     */
    
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit |NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit;
    
    comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    
//    NSLog(@"%ld年",(long)[comps year]);
//    NSLog(@"%ld月",(long)[comps month]);
//    NSLog(@"%ld日",(long)[comps day]);
//    NSLog(@"%ld时",(long)[comps hour]);
//    NSLog(@"%ld分",(long)[comps minute]);
//    NSLog(@"%ld秒",(long)[comps second]);
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.hour = [comps hour];
    dateComponents.minute = [comps minute];
    dateComponents.second = [comps second];
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:startDate options:0];
    
    
    return date;
//    return [NSDate convertDateToSystemZone:startDate];
}



- (NSUInteger)weeklyOrdinality{
    
    // 获取一个小的单位在一个大的单位里面的序数
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
    
}


- (NSUInteger)numberOfWeeksInCurrentMonth{
    
    // 获取当前月第一天处于对应周的天数
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    
    // 获取当前月的天数
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1); // days减去第一行的天数
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}


+ (NSDate *)convertDateToSystemZone:(NSDate *)date{
    
    // 获取系统的当前时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 以秒为单位返回指定时间与世界标准时间（格林威尼时间）的时差
    NSInteger interval = [zone secondsFromGMTForDate: date];
    // 然后加上时差,就是当前系统准确的时间
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


/// 在当前日期的基础上增加上指定天数
- (NSDate *)additionDay:(NSInteger)dayNumber{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = dayNumber;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    
}


/**
 *  在当前月的基础上增加上指定月数
 *
 *  @param monthNumber 欲添加的月数
 */
-(NSDate *)additionMonth:(NSInteger)monthNumber{
    
    if(monthNumber == 0){
        return self;
    }
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = monthNumber;
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.firstDayOfCurrentMonth options:0];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    
    // stringFromDate默认将时间转为本地时区的字符串，即+8
    // dateFromString默认将字符串转为0时区的date
    return [format dateFromString:[format stringFromDate:date]];
}



@end
