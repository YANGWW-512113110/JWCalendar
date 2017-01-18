//
//  JWCalendarConfig.h
//  Quick_start
//
//  Created by administrator on 29/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 日历控件的配置

@interface JWCalendarConfig : NSObject


#pragma mark 颜色字体配置

/// 周bar中的字体颜色
@property (strong,nonatomic) UIColor *weekFontColor;

/// 周bar中的字体
@property (strong,nonatomic) UIFont *weekFont;

/// 周bar的背景色
@property (strong,nonatomic) UIColor *weekBackgroundColor;

/// 周bar中分隔线的颜色
@property (strong,nonatomic) UIColor *weekLineBetweenColor;



/// 日历中的字体颜色
@property (strong,nonatomic) UIColor *calendarFontColor;

/// 日历中的字体
@property (strong,nonatomic) UIFont *calendarFont;

/// 日历的背景色
@property (strong,nonatomic) UIColor *calendarBackgroundColor;

/// 日历中分隔线的颜色
@property (strong,nonatomic) UIColor *calendarLineBetweenColor;


/// 选中状态下的日历中字体颜色
@property (strong,nonatomic) UIColor *calendarFontColorForSelected;

/// 选中状态下的日历中字体
@property (strong,nonatomic) UIFont *calendarFontForSelected;

/// 选中状态下的日历背景色
@property (strong,nonatomic) UIColor *calendarBackgroundColorForSelected;


/// 禁用状态下的日历中字体颜色
@property (strong,nonatomic) UIColor *calendarFontColorForDisable;

/// 禁用状态下的日历中字体
@property (strong,nonatomic) UIFont *calendarFontForDisable;

/// 禁用状态下的日历背景色
@property (strong,nonatomic) UIColor *calendarBackgroundColorForDisable;


/// 日历中"今天"字体颜色
@property (strong,nonatomic) UIColor *calendarFontColorForToday;



#pragma mark 间距配置

/**
 *  Day View的宽高比，默认
 */
@property (assign,nonatomic) CGFloat dayViewRate;

/**
 *  列间距，默认
 */
@property (assign,nonatomic) CGFloat columnSpacing;

/**
 *  行间距，默认
 */
@property (assign,nonatomic) CGFloat rowSpacing;

/**
 *  底部边距，默认
 */
@property (assign,nonatomic) CGFloat bottomMargin;

/**
 *  周bar中的每个子view的宽高比，默认为1; 周bar中共有7个子view分别表示周一到周日;
 */
@property (assign,nonatomic) CGFloat weekViewRate;

/**
 *  周bar的高度
 */
@property (assign,nonatomic) CGFloat weekBarHeigth;

/**
 *  周bar中UILabel的水平间距
 */
@property (assign,nonatomic) CGFloat horizontalSpacingInWeekBar;

/**
 *  周bar的前、后边距
 */
@property (assign,nonatomic) CGFloat weekBarFrontAndBackMargin;

/**
 *  周bar底部边线的宽度,注：边线在周bar内部，不会额外增加周bar的高度
 */
@property (assign,nonatomic) CGFloat weekBarBottomLineWidth;



/**
 *  周bar和日历的间距，默认
 */
@property (assign,nonatomic) CGFloat weekBarAndCalendarSpacing;

/**
 *  month view之间的间距，默认为1.0；
 */
@property (assign,nonatomic) CGFloat monthCalendarSpacing;




#pragma mark 控件内部属性，其值自动生成，外部不可设置

/// DayView的大小,由控件内自动计算
@property (assign,nonatomic) CGSize dayViewSize;


@end
