//
//  WeekView.m
//  Quick_start
//
//  Created by administrator on 29/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

#import "WeekView.h"

@interface WeekView()<DayViewDelegat>


/// 保存日期对应的DayView;日期为key,其格式为:yyyy-MM-dd
@property (strong,nonatomic) NSMutableDictionary *dateAndDayView;

@property (strong,nonatomic) NSMutableArray<DayView *> *dayViewArray;

@end

@implementation WeekView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.dayViewArray = [NSMutableArray array];
    }
    
    return self;
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    if(self.dayViewArray.count > 0){
        return;
    }
    
    // 配置外观
    self.backgroundColor = self.config.calendarLineBetweenColor;
    
    
    // 创建子view
    CGSize dayViewSize = self.config.dayViewSize;
    
    for(NSInteger i=0;i<7;i++){

        CGFloat x = self.config.monthCalendarSpacing/2.0 + i*(self.config.columnSpacing + dayViewSize.width);
        
        DayView *view = [[DayView alloc] initWithFrame:CGRectMake(x,0,dayViewSize.width,dayViewSize.height)];
        
        view.config = self.config;
        view.delegate = self;
        
        view.dateMonth = 0;
        view.date = [NSDate currentDate];

        
        view.hidden = NO;
        
        [self addSubview:view];
        
        [self.dayViewArray addObject:view];
        
    }
    
    [self fillDate];
}



-(void)setStartDate:(NSDate *)startDate{

    if(_startDate && [_startDate compare:startDate] == NSOrderedSame){
        return;
    }
    
    _startDate = startDate;
    
    if(self.dayViewArray.count > 0){
        [self fillDate];
    }

}


/// 向view中填充日期
-(void)fillDate{
    
    if(!self.startDate){
        return;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    NSDate *temp = nil;
    NSString *tempString = nil;
    [format setDateFormat:@"yyyy-MM-dd"];
    
    for (NSInteger i = 0; i < 7; i++) {
        
        temp = [_startDate additionDay:i];
        
        tempString = [format stringFromDate:temp];
        
        [self.dateAndDayView setObject:self.dayViewArray[i] forKey:tempString];
        
        if(self.needMarketDate && [self.needMarketDate containsObject:tempString]){
            [self.dayViewArray[i] markedDayAndSetDate:temp];
        }else{
            self.dayViewArray[i].isMarkedDay = NO;
            self.dayViewArray[i].date = temp;
        }
        
        if(self.dayViewArray[i].isToday){
            _today = temp;
        }
    }
    
}


-(void)dayViewWithClick:(DayView *)dayView{
    
    if([self.delegate respondsToSelector:@selector(weekViewClickWithDate:)]){
        [self.delegate weekViewClickWithDate:dayView.date];
    }
}


@end
