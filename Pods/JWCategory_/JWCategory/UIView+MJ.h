//
//  UIView+MJ.h
//  QQZoneDemo
//
//  Created by MJ Lee on 14-5-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/**
 *  简化frame的获取
 */

#import <UIKit/UIKit.h>

@interface UIView (MJ)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@end
