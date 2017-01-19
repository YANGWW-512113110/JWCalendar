//
//  UIBarButtonItem+JW.m
//  ErTong
//
//  Created by administrator on 16/5/27.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

// 按钮高度
#define buttonItemHeigth 25

// 按钮位置
#define buttonItemPoint CGPointMake(0, 0)

// 按钮图标大小
#define iconSize buttonItemHeigth

// 按钮最小宽度；程序会自动根据图标和title计算并设定按钮宽度，但如果按钮宽度太小，就会造成点击困难；因此需要设定最小宽度；
#define buttonMinWidth 60

// title字体
#define titleFont [UIFont systemFontOfSize:17]

// 图标和title的间距
#define iconTitleSpacing 3

// 按钮与屏幕边界的偏移
#define negativeSpacerWidth -8;

#import "UIBarButtonItem+JW.h"


@implementation UIBarButtonItem (JW)


+(NSArray<UIBarButtonItem *> *)itemWithLeftIcon:(NSString *)leftIcon title:(NSString *)title target:(id)target actioin:(SEL)action{

    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace                                                                             target:nil action:nil];
    
    negativeSpacer.width = negativeSpacerWidth;// 这个数值可以根据情况自由变化
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithTitileIcon:leftIcon title:title];
    if(item){
        return @[negativeSpacer,item];
    }
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // title
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;

    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,buttonItemHeigth) options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:button.titleLabel.font}
                                      context:nil].size;
    // button
    button.frame = (CGRect){buttonItemPoint.x,buttonItemPoint.y,titleSize.width +  (leftIcon?iconSize:0) + iconTitleSpacing,buttonItemHeigth};
    
    if (leftIcon) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0,-[UIImage imageNamed:leftIcon].size.width + iconSize + iconTitleSpacing, 0.0,0);
    }

    
    // icon
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0,0.0,0.0,button.frame.size.width-iconSize);

    [button setImage:[UIImage imageNamed:leftIcon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:leftIcon] forState:UIControlStateHighlighted];
    

    
    // button
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    

    
    return @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:button]];
}

+(NSArray<UIBarButtonItem *> *)itemWithRightIcon:(NSString *)righhtIcon title:(NSString *)title target:(id)target actioin:(SEL)action{

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace                                                                             target:nil action:nil];
    
    negativeSpacer.width = negativeSpacerWidth;// 这个数值可以根据情况自由变化
    
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithTitileIcon:righhtIcon title:title];
    if(item){
        return @[negativeSpacer,item];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // title
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,buttonItemHeigth) options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:button.titleLabel.font}
                                           context:nil].size;
    // button
    button.frame = (CGRect){buttonItemPoint.x,buttonItemPoint.y,titleSize.width + (righhtIcon?iconSize:0) + iconTitleSpacing,buttonItemHeigth};
    
    if (righhtIcon) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0,-[UIImage imageNamed:righhtIcon].size.width, 0.0,0);
    }
    
    // icon
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0,titleSize.width +iconTitleSpacing,0.0,0);
    
    
    [button setImage:[UIImage imageNamed:righhtIcon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:righhtIcon] forState:UIControlStateHighlighted];
    
    
    
    // button
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:button]];
}



+(UIBarButtonItem*)leftBackButtonIcon:(NSString *)icon target:(id)target actioin:(SEL)action{

    UIImage *image=[UIImage imageNamed:icon];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(buttonItemPoint.x,buttonItemPoint.y, buttonItemHeigth-3,buttonItemHeigth-3);
    
    [btn setImage:image forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backItem;
}

// 判空
+(UIBarButtonItem*)itemWithTitileIcon:(NSString*)icon title:(NSString *)title{


    if (!icon && !title) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"null" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 70, 30);
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return nil;
}

@end
