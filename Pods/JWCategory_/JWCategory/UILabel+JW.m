//
//  UILabel+JW.m
//  ErTong
//
//  Created by administrator on 16/6/12.
//  Copyright © 2016年 YANGWW. All rights reserved.
//

#import "UILabel+JW.h"

@implementation UILabel (JW)

-(CGSize)textSize{


    // NSMutableParagraphStyle用于设置段落样式
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;           // 换行方式
    //    paragraphStyle.alignment = NSTextAlignmentCenter;                   // 对齐方式
    //    paragraphStyle.lineSpacing = 10.0;                                  // 行间距
    //    paragraphStyle.paragraphSpacing = 20.0;                             // 段落间距
    //    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;// 书写方式
    //    paragraphStyle.firstLineHeadIndent = 0.0;                           // 首行缩进
    //    paragraphStyle.headIndent = 50.0;                                   // 除首行之外其他行缩进
    // 其它......
    
    // 属性attribute用于设置字体、字号、前景色、背景色、下划线等；
    NSDictionary*attribute = @{NSFontAttributeName:self.font};
    
    /* options选项：
     NSStringDrawingUsesLineFragmentOrigin：整个文本将以每行组成的矩形为单位计算尺寸。
     NSStringDrawingTruncatesLastVisibleLine：以每个字为单位来计算
     NSStringDrawingUsesDeviceMetric以：以每个字形为单位来计算。
     NSStringDrawingUsesFontLeading：以字体间的行距来计算。
     
     
     context上下文。包括一些信息，例如如何调整字间距以及缩放。最终，该对象包含的信息将用于文本绘制。该参数可为 nil 。
     */
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT,self.frame.size.height) options: NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    

    return size;
}

@end
