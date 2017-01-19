//
//  CVKHierarchySearcher.h
//  CVKHierarchySearcher
//
//  Created by Romans Karpelcevs on 12/10/14.
//  Copyright (c) 2014 Romans Karpelcevs. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CVKHierarchySearcher : NSObject


/**
 *  顶层controller
 */
@property (nonatomic, readonly) UIViewController *topmostViewController;

/**
 *  顶层controller(不包含modal出的controller)
 */
@property (nonatomic, readonly) UIViewController *topmostNonModalViewController;


/**
 *  顶层navigationController
 */
@property (nonatomic, readonly) UINavigationController *topmostNavigationController;

@end
