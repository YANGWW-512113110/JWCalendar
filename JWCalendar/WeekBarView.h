//
//  WeekView.h
//  JWCalendarDemo
//
//  Created by administrator on 16/1/11.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWCalendarConfig.h"

@interface WeekBarView : UIView


@property (weak,nonatomic) JWCalendarConfig *config;


/**
 *  选中一周bar中的一天
 *
 *  @param index 天在周bar中的索引
 */
-(void)selectWeekWithIndex:(NSInteger) index;


@end
