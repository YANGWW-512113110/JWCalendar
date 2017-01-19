//
//  CVKHierarchySearcher.m
//  CVKHierarchySearcher
//
//  Created by Romans Karpelcevs on 12/10/14.
//  Copyright (c) 2014 Romans Karpelcevs. All rights reserved.
//

#import "CVKHierarchySearcher.h"

@implementation CVKHierarchySearcher

/**
 *  获取顶层controller(包含modal出的controller)
 *
 *  @return
 */
- (UIViewController *)topmostViewController{
    
    return [self topmostViewControllerFrom:[[self baseWindow] rootViewController]
                              includeModal:YES];
}

/**
 *  获取顶层controller(不包含modal出的controller)
 *
 *  @return
 */
- (UIViewController *)topmostNonModalViewController{
    
    return [self topmostViewControllerFrom:[[self baseWindow] rootViewController]
                              includeModal:NO];
}

/**
 *  获取顶层navationController
 *
 *  @return 
 */
- (UINavigationController *)topmostNavigationController{
    
    return [self topmostNavigationControllerFrom:[self topmostViewController]];
}

/**
 *  返回navigationController
 *
 *  @param vc
 *
 *  @return
 */
- (UINavigationController *)topmostNavigationControllerFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]])
        return (UINavigationController *)vc;
    if ([vc navigationController])
        return [vc navigationController];

    return nil;
}

/**
 *  获取最顶层的view
 *
 *  @param viewController
 *  @param includeModal     是否包含modal弹出的viewController
 *
 *  @return
 */
- (UIViewController *)topmostViewControllerFrom:(UIViewController *)viewController
                                   includeModal:(BOOL)includeModal{
    
    // 若selectedViewController不会空，说明此VC为UITabBarController
    if ([viewController respondsToSelector:@selector(selectedViewController)])
        return [self topmostViewControllerFrom:[(id)viewController selectedViewController]
                                  includeModal:includeModal];

    // presentedViewController是通过modal弹出的viewController
    if (includeModal && viewController.presentedViewController)
        return [self topmostViewControllerFrom:viewController.presentedViewController
                                  includeModal:includeModal];

    // topViewController属性是UINavigationController栈顶的viewController
    if ([viewController respondsToSelector:@selector(topViewController)])
        return [self topmostViewControllerFrom:[(id)viewController topViewController]
                                  includeModal:includeModal];

    return viewController;
}


// 获取根据window
- (UIWindow *)baseWindow{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (!window)
        window = [[UIApplication sharedApplication] keyWindow];

    NSAssert(window != nil, @"No window to calculate hierarchy from");
    return window;
}

@end
