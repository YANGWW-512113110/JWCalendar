//
//  NSString+JW.h
//  Quick_start
//
//  Created by administrator on 24/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JW)

/// 转换对象为字符串
+ (instancetype)convertToStringWithObj:(id)obj;

/// 转换数字为字符串，不保留小数
+ (instancetype)convertDigitalToStringWithObj:(id)obj;

/// 转换数字为字符串，保留1位小数
+ (instancetype)convertDigitalToString1WithObj:(id)obj;

/// 转换数字为字符串，保留2位小数
+ (instancetype)convertDigitalToString2WithObj:(id)obj;


/// 去掉前后空格
- (NSString *)trim;

/// 去掉前后回车符
- (NSString *)trimNewline;

/// 去掉前后空格和回车符
- (NSString *)trimWhitespaceAndNewline;

/**
 *  去掉特殊字符
 *
 *  @param characterSet 特殊字符
 *
 *  @return 过滤后的字符串
 */
-(NSString *)trimCharacterSet:(NSCharacterSet *)characterSet;

@end
