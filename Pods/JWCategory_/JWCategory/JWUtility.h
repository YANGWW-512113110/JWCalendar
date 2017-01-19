//
//  Utility_JW.h
//  Quick_start
//
//  Created by administrator on 16/11/10.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWUtility : NSObject

/// 判空
+(BOOL)isEmpty:(id)object;

/// 弹出提示
+(void)alert:(NSString *)message;

/// 弹出提示
+(void)alert:(NSString *)message finishBlock:(void (^)())finishBlock cancelBlock:(void (^)())cancelBlock;

@end
