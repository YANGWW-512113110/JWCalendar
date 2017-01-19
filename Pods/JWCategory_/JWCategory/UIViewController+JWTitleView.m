//
//  UIViewController+JWTitleView.m
//  leshi-OA
//
//  Created by administrator on 16/4/20.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "UIViewController+JWTitleView.h"
#import <objc/runtime.h>

@interface UIViewController ()


/**
 *  当前UIViewController如果已创建了JWTitleView，则jwtitleView不为空；jwtitleView用于避免同一个UIViewController中JWTitleView重复创建；
 */
@property (weak,nonatomic) UIView *jwtitleView;


@property (strong,nonatomic) UIView *originTitleView;

@property  (strong,nonatomic) NSString *originTitle;

/**
 *  加载计数
 */
@property (assign,atomic) int loadCount;

@end


@implementation UIViewController (JWTitleView)

-(int)loadCount{
    return [objc_getAssociatedObject(self, @selector(loadCount)) intValue];
}

-(void)setLoadCount:(int)loadCount{
    objc_setAssociatedObject(self, @selector(loadCount), @(loadCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)jwtitleView{
    return objc_getAssociatedObject(self, @selector(jwtitleView));
}

-(void)setJwtitleView:(UIView *)jwtitleView{
    objc_setAssociatedObject(self, @selector(jwtitleView), jwtitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)originTitleView{
    return objc_getAssociatedObject(self, @selector(originTitleView));
}

-(void)setOriginTitleView:(UIView *)originTitleView{
    objc_setAssociatedObject(self, @selector(originTitleView), originTitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)originTitle{
    return objc_getAssociatedObject(self, @selector(originTitle));
}

-(void)setOriginTitle:(NSString *)originTitle{
    objc_setAssociatedObject(self, @selector(originTitle), originTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)loadingData{
    
    [self loadingDataForTitle:@"接收数据..."];
}

-(void)loadingDataForTitle:(NSString *)title{
    
    
    self.loadCount++;
    
    if(self.jwtitleView){
        return;
    }
    
    // save origin view
    if (self.navigationItem.titleView) {
        self.originTitleView = self.navigationItem.titleView;
    }else if(self.navigationItem.title){
        self.originTitle = self.navigationItem.title;
    }
    
    UIView * titleView = [[UIView alloc] init];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activity.frame = CGRectMake(0, 13, activity.frame.size.width, activity.frame.size.height);
    [activity startAnimating];
    [titleView addSubview:activity];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleView addSubview:titleLabel];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font  = [UIFont boldSystemFontOfSize:18];
    
    
    CGSize size = [titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
    
    titleLabel.frame = CGRectMake(activity.bounds.size.width + 5,12,size.width,size.height);
    
    titleView.frame = CGRectMake(0, 0,activity.bounds.size.width + 5 + size.width, 44);
    
    self.navigationItem.titleView = titleView;
    self.jwtitleView = titleView;
    
}

-(void)LoadComplete{
    
    self.loadCount--;
    
    if (self.loadCount != 0) {
        return;
    }
    
    self.navigationItem.titleView = nil;
    self.jwtitleView = nil;
        
    if (self.originTitleView) {
        self.navigationItem.titleView = self.originTitleView;
    }else if(self.originTitle){
        self.navigationItem.title = self.originTitle;
    }
    
}


@end
