//
//  UIColor+JW.h
//  ErTong
//
//  Created by administrator on 16/6/13.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JW)

/**
 *   根据十六进制颜色字符串获取UIColor
 *
 *  @param hexString  十六进制字符串
 *
 */
+(UIColor *)hexColor:(NSString *)hexString;


/// 产生随机色
+(instancetype)randomColor;
    
@end
