//
//  DayView.m
//  JWTest
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

/**
 *  天：即控件中的每一个小方块
 */
#import "DayView.h"
#import "MonthView.h"
#import "JWCalendarUtility.h"


@interface DayView ()

/// 显示日期的UILabel
@property (weak,nonatomic) UILabel *dayLabel;

/// 是否为选中状态
@property (assign,nonatomic) BOOL isSelected;

@property (strong,nonatomic) NSTimer *timer;

@property (strong,nonatomic) NSDateFormatter *dateFormat;

@end


@implementation DayView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.isSelected = NO;
        _isToday = NO;
        _isCurrentMonth = NO;
        
        self.dateFormat = [[NSDateFormatter alloc] init];
        self.dateMonth = 0;
       
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height)];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel = dayLabel;
        [self addSubview:dayLabel];
    }
    return self;
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    self.dayLabel.frame = CGRectMake(0,0, self.width,self.height);
}

-(void)setDate:(NSDate *)date{

    _date = date;
    
    if(isEmpty(@(self.dateMonth))){
        return;
    }
    
    [self.dateFormat setDateFormat:@"dd"];
    self.dayLabel.text = [self.dateFormat stringFromDate:date];
    
    [self.dateFormat setDateFormat:@"MM"];
    NSInteger month = [[self.dateFormat stringFromDate:date] integerValue];
    
    NSInteger dayNumberInWeek = [date weeklyOrdinality];
    
    
    BOOL isCurrentMonth = NO;
    BOOL isWeekend      = NO;
    BOOL isToday        = NO;
    BOOL isSelected     = NO;
    
    // 判断是否为当前月
    if(self.dateMonth == month){
        isCurrentMonth = YES;
        _isCurrentMonth = YES;
    }else if(self.dateMonth == 0){
        isCurrentMonth = YES;
        _isCurrentMonth = YES;
    }else{
        isCurrentMonth = NO;
        _isCurrentMonth = NO;
    }
    
    // 判断是否为周末
    if(dayNumberInWeek == 1 || dayNumberInWeek == 7){
        isWeekend = YES;
    }else{
        isWeekend = NO;
    }
    
    // 判断是否为今天
    [self.dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [self.dateFormat stringFromDate:date];
    NSString *todayString = [self.dateFormat stringFromDate:[NSDate date]];
    if([todayString isEqualToString:dateString]){
        isToday = YES;
        _isToday = YES;
    }else{
        isToday = NO;
        _isToday = NO;
    }
    
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent:)];
    
    // 正常状态
    if(isCurrentMonth && !isWeekend && !isToday && !isSelected && !_isMarkedDay){
    
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
    
    }else if(!isCurrentMonth && !isWeekend && !isToday && !isSelected && !_isMarkedDay){
    // 禁用状态
        
        self.backgroundColor = self.config.calendarBackgroundColorForDisable;
        self.dayLabel.font = self.config.calendarFontForDisable;
        self.dayLabel.textColor = self.config.calendarFontColorForDisable;
        
    }else if(isCurrentMonth && isWeekend && !isToday && !isSelected && !_isMarkedDay){
    // 正常状态下的周末
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
    
    }else if(!isCurrentMonth && isWeekend && !isToday && !isSelected && !_isMarkedDay){
    // 禁用状态下的周末
        
        self.backgroundColor = self.config.calendarBackgroundColorForDisable;
        self.dayLabel.font = self.config.calendarFontForDisable;
        self.dayLabel.textColor = self.config.calendarFontColorForDisable;
        
    }else if(isCurrentMonth && !isWeekend && !isToday && isSelected && !_isMarkedDay){
    // 正常状态下的选中
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(!isCurrentMonth && !isWeekend && !isToday && isSelected && !_isMarkedDay){
    // 禁用状态下的选中
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(!isCurrentMonth && isWeekend && !isToday && isSelected && !_isMarkedDay){
    // 禁用状态下的选中为周末
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(isCurrentMonth && isWeekend && !isToday && isSelected && !_isMarkedDay){
    // 正常状态下的选中为周末
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(!isCurrentMonth && !isWeekend && isToday && isSelected && !_isMarkedDay){
    // 禁用状态下的选中为今天
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(isCurrentMonth && !isWeekend && isToday && isSelected && !_isMarkedDay){
    // 正常状态下的选中为今天
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColorForToday;
        
    }else if(isCurrentMonth && !isWeekend && isToday && !isSelected && !_isMarkedDay){
    // 正常状态下的今天
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColorForToday;
        
    }else if(!isCurrentMonth && !isWeekend && isToday && !isSelected && !_isMarkedDay){
    // 禁用状态下的今天

        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(isCurrentMonth && isWeekend && isToday && !isSelected && !_isMarkedDay){
    // 正常状态下的今天为周末
        
        [self addGestureRecognizer:tapGesture];
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(!isCurrentMonth && isWeekend && isToday && !isSelected && !_isMarkedDay){
    // 禁用状态下的今天为周末
        
        self.backgroundColor = self.config.calendarBackgroundColor;
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = self.config.calendarFontColor;
        
    }else if(!isCurrentMonth && !isWeekend && !isToday && !isSelected && _isMarkedDay){
    // 禁用状态下被标记
        
        self.backgroundColor = self.config.calendarBackgroundColorForDisable;
        self.dayLabel.font = self.config.calendarFontForDisable;
        self.dayLabel.textColor = self.config.calendarFontColorForDisable;
        
    }else if(isCurrentMonth && !isWeekend && !isToday && !isSelected && _isMarkedDay){
    // 正常状态下被标记
       
        self.backgroundColor = [UIColor colorWithRed:0.1922 green:0.6078 blue:1.0 alpha:1.0];
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = [UIColor whiteColor];
    
    }else if(isCurrentMonth && isWeekend && !isToday && !isSelected && _isMarkedDay){
    // 被标记的天为周末
        
        self.backgroundColor = [UIColor colorWithRed:0.1922 green:0.6078 blue:1.0 alpha:1.0];
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = [UIColor whiteColor];
        
    }else if(isCurrentMonth && !isWeekend && isToday && !isSelected && _isMarkedDay){
    // 被标记的天为今天
        
        self.backgroundColor = [UIColor colorWithRed:0.1922 green:0.6078 blue:1.0 alpha:1.0];
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = [UIColor redColor];
        
    }else if(isCurrentMonth && isWeekend && isToday && !isSelected && _isMarkedDay){
        // 被标记的天为今天，且今天是周末
        
        self.backgroundColor = [UIColor colorWithRed:0.1922 green:0.6078 blue:1.0 alpha:1.0];
        self.dayLabel.font = self.config.calendarFont;
        self.dayLabel.textColor = [UIColor redColor];
        
    }else{
    
        NSString *errorInfo = [NSString stringWithFormat:@"JWCalendar:未知状态；isCurrentMonth:%d,isWeekend:%d,isToday:%d,isSelected:%d,_isMarkedDay:%d",isCurrentMonth,isWeekend,isToday,isSelected,_isMarkedDay];
        [JWCalendarUtility feedbackExceptionDataWidthExceptionContent:errorInfo];
    }
    

}

-(void)setIsMarkedDay:(BOOL)isMarkedDay{

    _isMarkedDay = isMarkedDay;
    
    self.date = _date;
}

-(void)markedDayAndSetDate:(NSDate *)date{

    if(date || _date){
       
        _isMarkedDay = YES;
        
        if(!date){
            self.date = _date;
        }else{
            self.date = date;
        }        
    }

}

-(void)cancelMarked{
    
    if(_date){
        _isMarkedDay = NO;
        self.date = _date;
    }
    
}

/**
 *  点击
 */
-(void)clickEvent:(UITapGestureRecognizer *)tap{

    if([self.delegate respondsToSelector:@selector(dayViewWithClick:)]){
        [self.delegate dayViewWithClick:self];
    }

}

@end
