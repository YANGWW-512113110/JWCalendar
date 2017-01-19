//
//  UIColor+JW.m
//  ErTong
//
//  Created by administrator on 16/6/13.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "UIColor+JW.h"

@implementation UIColor (JW)


+(UIColor *)hexColor:(NSString *)hexString{

    // 如果存在#号，则删除
    if ([hexString containsString:@"#"]) {
        hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    
}


+ (instancetype)randomColor{

    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}

@end
