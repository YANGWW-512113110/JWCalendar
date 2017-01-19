//
//  UIBarButtonItem+JW.h
//  ErTong
//
//  Created by administrator on 16/5/27.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JW)

/**
 *  创建一个导航栏按钮，可以只设置图标或title;
 *
 *  @param leftIcon  按钮图标(图标居左)
 *  @param title     title
 *  @param target    target
 *  @param action    回调
 *
 *  @return          UIBarButtonItem数组
 */
+(NSArray<UIBarButtonItem*> *)itemWithLeftIcon:(NSString *)leftIcon title:(NSString *)title target:(id)target actioin:(SEL)action;


/**
 *  创建一个导航栏按钮，可以只设置图标或title;
 *
 *  @param righhtIcon 按钮图标(图标居右)
 *  @param title      title
 *  @param target     target
 *  @param action     回调
 *
 *  @return           UIBarButtonItem数组
 */
+(NSArray<UIBarButtonItem*> *)itemWithRightIcon:(NSString *)righhtIcon title:(NSString *)title target:(id)target actioin:(SEL)action;

/**
 *  创建导航栏返回按钮
 *
 *  @param icon        icon
 *  @param target      target
 *  @param action      回调
 *
 *  @return            UIBarButtonItem
 */
+(UIBarButtonItem*)leftBackButtonIcon:(NSString *)icon target:(id)target actioin:(SEL)action;

@end
