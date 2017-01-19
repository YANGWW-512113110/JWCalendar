//
//  UIButton+JW.m
//  ErTong
//
//  Created by administrator on 16/6/12.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "UIButton+JW.h"
#import "UILabel+JW.h"
#import "UIView+MJ.h"


// title和图片的间距
#define titleImageSpacing 5.0

@implementation UIButton (JW)


-(void)titleButtomImageTop{

    
    CGSize textSize = [self.titleLabel textSize];
    
    self.frame = CGRectMake(self.x, self.y, self.width,self.width+textSize.height + titleImageSpacing);
    
    
   
    // 直接拉大titleLabel为button的宽度
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.height/2 - (textSize.height/2 + titleImageSpacing),-self.imageView.image.size.width,-(self.height/2 - textSize.height/2 + titleImageSpacing), 0)];
    
    // 偏移image至button中心
    [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,textSize.height + titleImageSpacing,0)];
    
    
}

@end
