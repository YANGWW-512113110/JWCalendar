//
//  Utility_JW.m
//  Quick_start
//
//  Created by administrator on 16/11/10.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "CVKHierarchySearcher.h"
#import "NSString+JW.h"

#import "JWUtility.h"

@implementation JWUtility

// 注:此方法不可添加到分类中，因为对象为nil时无法调用分类的方法；
+(BOOL)isEmpty:(id)object{

    if(object == nil || object == NULL || object == false || object == Nil){  // 判空对象
        
        return YES;
        
    }else if([object isEqual:[NSNull null]]){
        
        return YES;
        
    }else if([object isKindOfClass:[NSString class]] && [[((NSString *)object) trimWhitespaceAndNewline] length] <= 0){ // 判空字符串
        
        return YES;
        
    }else if([object isKindOfClass:[NSArray class]] && ((NSArray *)object).count <= 0){ // 判空数组
        
        return YES;
        
    }else if([object isKindOfClass:[NSDictionary class]] && ((NSDictionary *)object).count <= 0){ // 判空字典
        
        return YES;
    }
    
    return NO;
}

/// 弹出提示
+(void)alert:(NSString *)message{

    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建操作
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];
    
    // 添加操作
    [alertDialog addAction:okAction];
    
    CVKHierarchySearcher *searcher = [[CVKHierarchySearcher alloc] init];
    UIViewController *topmostVC = [searcher topmostViewController];
    
    // 呈现警告视图
    [topmostVC presentViewController:alertDialog animated:YES completion:nil];
    

}


+(void)alert:(NSString *)message finishBlock:(void (^)())finishBlock cancelBlock:(void (^)())cancelBlock{

    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建操作
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
        finishBlock();
        
    }];
    
    [alertDialog addAction:okAction];

    
    if(cancelBlock){
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            cancelBlock();
            
        }];
        
        [alertDialog addAction:cancelAction];
    }
  
    
    CVKHierarchySearcher *searcher = [[CVKHierarchySearcher alloc] init];
    UIViewController *topmostVC = [searcher topmostViewController];
    
    // 呈现警告视图
    [topmostVC presentViewController:alertDialog animated:YES completion:nil];

}



@end
