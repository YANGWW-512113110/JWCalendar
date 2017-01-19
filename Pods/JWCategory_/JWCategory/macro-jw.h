//
//  macro.pch
//  JWCategoryExample
//
//  Created by administrator on 16/10/21.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

// 屏幕尺寸
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGTH [[UIScreen mainScreen] bounds].size.height

/// 时间戳
#define Timestamp [NSDate timestamp_local]

// #import "AppDelegate.h"
// #define APP_Delegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

// RGB颜色
#define Color(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0)  blue:(c/255.0)  alpha:1.0]

// RGB Alpha颜色
#define ColorAlpha(a,b,c,d) [UIColor colorWithRed:(a/255.0) green:(b/255.0)  blue:(c/255.0)  alpha:(d/1.0)]

// 随机色
#define ColorRandom  [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0)  blue:(arc4random_uniform(255)/255.0)  alpha:1.0]


// 日志
//1) __VA_ARGS__ 是一个可变参数的宏。宏前面加##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的","去掉的作用,否则会编译出错
//2) __FILE__ 宏在预编译时会替换成当前的源文件名
//3) __LINE__宏在预编译时会替换成当前的行号
//4) __FUNCTION__宏在预编译时会替换成当前的函数名称
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s%s line:%d content:%s\n",[[NSString stringWithFormat:@"%@",Timestamp] UTF8String],__FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif




// 判空
#define isEmpty(s) [JWUtility isEmpty:(s)]

// 弹出提示
#define alert(s) [JWUtility alert:(s)]

// 四舍五入保留1位小数
#define roundf_1(s) roundf(s*10)/10

// 四舍五入保留2位小数
#define roundf_2(s) roundf(s*100)/100





