//
//  NSString+JW.m
//  Quick_start
//
//  Created by administrator on 24/12/2016.
//  Copyright © 2016 YANGWW. All rights reserved.
//
// #import <SystemConfiguration/CaptiveNetwork.h>

#import "NSString+JW.h"

@implementation NSString (JW)

+ (instancetype)convertToStringWithObj:(id)obj{

    return [NSString stringWithFormat:@"%@",obj];

}

+ (instancetype)convertDigitalToStringWithObj:(id)obj{

    NSString * str = [NSString stringWithFormat:@"%@",obj];
    
    return [NSString stringWithFormat:@"%.0f",[str floatValue]];
    
}

+ (instancetype)convertDigitalToString1WithObj:(id)obj{
    
    NSString * str = [NSString stringWithFormat:@"%@",obj];
    
    return [NSString stringWithFormat:@"%.1f",roundf([str floatValue]*10)/10];
    
}

+ (instancetype)convertDigitalToString2WithObj:(id)obj{
    
    NSString * str = [NSString stringWithFormat:@"%@",obj];
    
    return [NSString stringWithFormat:@"%.2f",roundf([str floatValue]*100)/100];
    
}


- (NSString *)trimCharacterSet:(NSCharacterSet *)characterSet {
    
    NSString *returnVal = @"";
    if (self) {
        returnVal = [self stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

- (NSString *)trim{
    return [self trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
}

- (NSString *)trimNewline{
    return [self trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
}

- (NSString *)trimWhitespaceAndNewline{
    return [self trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
}



@end
