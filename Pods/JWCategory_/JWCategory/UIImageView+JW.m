//
//  UIImageView+JW.m
//  ErTong
//
//  Created by administrator on 16/6/18.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "UIImageView+JW.h"

@implementation UIImageView (JW)


-(void)showCircularImage:(UIImage *)image{

    
    // 2.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画圆
    CGRect circleRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextAddEllipseInRect(ctx, circleRect);
    
    // 5.按照当前的路径形状(圆形)裁剪, 超出这个形状以外的内容都不显示
    CGContextClip(ctx);
    
    // 6.画图
    [image drawInRect:circleRect];


}

@end
