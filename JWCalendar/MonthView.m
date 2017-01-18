//
//  MonthView.m
//  JWTest
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

/**
 *  月：即日期控件中每一页
 */
#import "MonthView.h"
#import "WeekBarView.h"
#import "JWCalendar.h"

//@interface MonthView()<DayViewDelegat>
//
//@property (weak,nonatomic) UIView *mainView;
//
//// 行高
//@property (assign,nonatomic) CGFloat rowHeigth;
//
//// 选中行最初的Y值
//@property (assign,nonatomic) CGFloat selectedRowOriginY;
//
//// 当前选中的行
//@property (weak,nonatomic) UIView *selectedRowView;
//
//@property (strong,nonatomic)  NSDateFormatter *dateFormatter;

// 当前页中选中的DayView
//@property (weak,nonatomic) DayView *currentSelectedDayView;

//@end

@interface MonthView()<DayViewDelegat>


/// 当前MonthView的宽度
@property (assign,nonatomic) CGFloat currentWidth;

@end

@implementation MonthView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
//        [self initUI];
        
        [self setupDefaultValues];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.dayViewArray = [NSMutableArray array];
        
        self.dateAndDayView = [NSMutableDictionary dictionary];
        
//        [self initUI];
        
        [self setupDefaultValues];
    }
    
    return self;
}

-(void)initUI{

//    UILabel *l = [[UILabel alloc] init];
//    [self addSubview:l];
    
    
    
    
}

-(void)setupDefaultValues{

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    if(self.dayViewArray.count > 0){
        
        if(self.currentWidth != self.width){
        
            // 更新子view
            [self updateLayout];
        }
        
        self.currentWidth = self.width;
        
        [super layoutSubviews];
        
        return;
    }
    
    self.currentWidth = self.width;
    
    
    // 外观配置
    self.backgroundColor = self.config.calendarLineBetweenColor;

    
    // 6行7列；日历最多是6行7列，最少是5行7列，此处默认创建6行7列，以便适用所有的月；遇到5行7列的月时，自动隐藏最后一行； 
    CGSize dayViewSize = self.config.dayViewSize;
    
    NSInteger y = -1;
    for (int i = 0;i < 42; i++) {
        
        if(i%7 == 0){
            y++;
        }
        
        NSInteger x = i%7;
        
        CGFloat xCoordinateValue = self.config.monthCalendarSpacing/2.0 + x*(self.config.columnSpacing + dayViewSize.width);
        CGFloat yCoordinateValue = self.config.weekBarHeigth + self.config.weekBarAndCalendarSpacing + y*(self.config.rowSpacing+dayViewSize.height);
        
        DayView * view = [[DayView alloc] initWithFrame:CGRectMake(xCoordinateValue,yCoordinateValue, dayViewSize.width, dayViewSize.height)];
        view.config = self.config;
        view.delegate = self;
        
        [self addSubview:view];
        [self.dayViewArray addObject:view];
    }
 
    [self fillDate];
}


-(void)setDate:(NSDate *)date{

    if(_date && [_date compare:date] == NSOrderedSame){
        return;
    }
    
    _date = date;
    
    if(self.dayViewArray.count > 0){
        [self fillDate];
    }
    
}

/// 向view中填充日期
-(void)fillDate{

    if(!self.date){
        return;
    }
 
    NSDate *firstDay = _date.firstDayOfCurrentMonth;
    
    // 获取第一天处于对应周的第几天
    NSInteger weekDay = [firstDay weeklyOrdinality];
    
    NSDate *zeroIndexDate = [firstDay additionDay:-(weekDay-1)];
    
    NSInteger rowNumber = _date.numberOfWeeksInCurrentMonth; // 行数
 
    [self setMonthHeigthWithRowNumber:rowNumber];
 
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM"];
    NSInteger dateMonth = [[format stringFromDate:_date] integerValue];
    
    // 6行7列
    NSInteger dayNumber = rowNumber * 7;
    NSInteger i = 0;
    NSDate *temp = nil;
    NSString *tempString = nil;
    [format setDateFormat:@"yyyy-MM-dd"];
    [self.dateAndDayView removeAllObjects];
    
    _today = nil;
    for (; i < dayNumber; i++) {
        
        self.dayViewArray[i].dateMonth = dateMonth;
        
        temp = [zeroIndexDate additionDay:i];
        
        tempString = [format stringFromDate:temp];
        
        [self.dateAndDayView setObject:self.dayViewArray[i] forKey:tempString];
        
        if(self.needMarketDate && [self.needMarketDate containsObject:tempString]){
            [self.dayViewArray[i] markedDayAndSetDate:temp];
        }else{
            self.dayViewArray[i].isMarkedDay = NO;
            self.dayViewArray[i].date = temp;
        }
        
        self.dayViewArray[i].hidden = NO;
        
        if(self.dayViewArray[i].isCurrentMonth && self.dayViewArray[i].isToday){
            _today = temp;
        }
    }
    
    for(;i<42;i++){
        self.dayViewArray[i].hidden = YES;
    }
    
}


- (void)updateLayout{

    CGSize dayViewSize = self.config.dayViewSize;
    
    NSInteger count = self.dayViewArray.count;

    NSInteger y = -1;
    
    for(NSInteger i=0;i<count;i++){
        
        if(i%7 == 0){
            y++;
        }
        
        NSInteger x = i%7;
        
        CGFloat xCoordinateValue = self.config.monthCalendarSpacing/2.0 + x*(self.config.columnSpacing + dayViewSize.width);
        CGFloat yCoordinateValue = self.config.weekBarHeigth + self.config.weekBarAndCalendarSpacing + y*(self.config.rowSpacing+dayViewSize.height);
        
        self.dayViewArray[i].frame = CGRectMake(xCoordinateValue,yCoordinateValue, dayViewSize.width, dayViewSize.height); 
        
    }

    NSInteger rowNumber = _date.numberOfWeeksInCurrentMonth; // 行数
    
    [self setMonthHeigthWithRowNumber:rowNumber];
}

-(void)setMonthHeigthWithRowNumber:(NSInteger)rowNumber{

    // Month view 高度
    self.monthViewHeigth = self.config.dayViewSize.height*rowNumber + (rowNumber -1)*self.config.rowSpacing + self.config.bottomMargin;
    self.height = self.monthViewHeigth +  self.config.weekBarAndCalendarSpacing +self.config.weekBarHeigth;

}

#pragma mark 代理

- (void)dayViewWithClick:(DayView *)dayView{

    if([self.delegate respondsToSelector:@selector(monthViewClickWithDate:)]){
        [self.delegate monthViewClickWithDate:dayView.date];
    }
    
}



@end
