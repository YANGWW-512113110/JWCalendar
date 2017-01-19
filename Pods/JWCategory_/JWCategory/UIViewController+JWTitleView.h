//
//  UIViewController+JWTitleView.h
//  leshi-OA
//
//  Created by administrator on 16/4/20.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

/**
 *  仿微信，在导航栏上显示数据加载过程
 */

#import <UIKit/UIKit.h>

@interface UIViewController (JWTitleView)

/// 注：短时间内连续多次使用相同URL和参数调用AFNetworking时，它只会发送一次请求；即,AFNetworking的成功回调只会被调用一次；这可能会导致loadingData和LoadComplete调用的次数不一致，从而使加载过程永远不会停止；因此你必须在代码中避免这种情况，以保证loadingData和LoadComplete的调用次数相同；

/**
 *  加载数据...
 */
-(void)loadingData;

/**
 *  加载数据...
 *
 *  @param title 自定义加载数据时的提示语
 */
-(void)loadingDataForTitle:(NSString *)title;

/**
 *  加载完成
 */
-(void)LoadComplete;

@end
