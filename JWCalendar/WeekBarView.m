//
//  WeekView.m
//  JWCalendarDemo
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WeekBarView.h"

@interface WeekBarView ()

@end

@implementation WeekBarView


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat itemWidth = (self.width - (self.config.horizontalSpacingInWeekBar * 6) - self.config.weekBarFrontAndBackMargin)/7;
    CGFloat itemHeigth = self.height;
    
    CGFloat margin= self.config.weekBarFrontAndBackMargin/2.0;
    
    if(self.subviews.count > 0){
    
        NSInteger count = self.subviews.count;
      
        // 刷新布局
        for (NSInteger i=0; i < count; i++) {
            
            if([self.subviews[i] isKindOfClass:[UILabel class]]){
            
                UILabel *label = (UILabel *)self.subviews[i];
                label.frame = CGRectMake(margin + i*(itemWidth+self.config.horizontalSpacingInWeekBar), 0, itemWidth, itemHeigth - self.config.weekBarBottomLineWidth);
            }
        }

        return;
    }
    
    self.backgroundColor = self.config.weekLineBetweenColor;
    
    NSArray *weekList = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    
    for (NSInteger i=0; i<7; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(margin + i*(itemWidth+self.config.horizontalSpacingInWeekBar), 0, itemWidth, itemHeigth - self.config.weekBarBottomLineWidth)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weekList[i];
        label.font = self.config.weekFont;
        label.textColor = self.config.weekFontColor;
        label.backgroundColor = self.config.weekBackgroundColor;
        [self addSubview:label];
    }
    
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 低部边线
    CGContextSetLineWidth(ctx,self.config.weekBarBottomLineWidth);                          // 线宽
    CGContextSetRGBStrokeColor(ctx, 218.0/255.0, 218.0/255.0, 218.0/255.0, 1);
    CGContextMoveToPoint(ctx, 0,self.frame.size.height - self.config.weekBarBottomLineWidth/2.0);
    CGContextAddLineToPoint(ctx,self.frame.size.width,self.frame.size.height - self.config.weekBarBottomLineWidth/2.0);
    CGContextStrokePath(ctx);

    // 渲染到view上
    CGContextStrokePath(ctx);
    
}


-(void)selectWeekWithIndex:(NSInteger)index{
 
    UILabel *temp =nil;
    
    for (int i = 0; i < 7; i++) {
        if (i == index) {
            temp =  ((UILabel *)self.subviews[i]);
            temp.font = [UIFont boldSystemFontOfSize:13.0f];
             temp.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];

        }else{
            temp =  ((UILabel *)self.subviews[i]);
            temp.font = [UIFont systemFontOfSize:13.0f];
            temp.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        }
    }

}

@end
