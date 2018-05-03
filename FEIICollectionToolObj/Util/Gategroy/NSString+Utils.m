//
//  NSString+Utils.m
//  dploffice
//
//  Created by shine-team2 on 2016/10/19.
//  Copyright © 2016年 com. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)generateSmallImgUrl {
    
    NSRange lastIndex = [self rangeOfString:@"." options:NSBackwardsSearch];
    if (lastIndex.location != NSNotFound) {
        NSString *suffix = [self substringFromIndex:lastIndex.location];
        NSString *wholeSuffix = [SMALL_IMG_SUFFIX stringByAppendingString:suffix];
        NSString *pre = [self substringWithRange:NSMakeRange(0, lastIndex.location)];
        return [pre stringByAppendingString:wholeSuffix];
    }
    
    return nil;
}

+ (NSString *)HomoetimeConversion:(NSString *)time
{
    NSDateFormatter *longFormatter = [[NSDateFormatter alloc]init];
    [longFormatter setDateFormat:@"HH:mm"];
    
    NSDateFormatter *homeFormatter = [[NSDateFormatter alloc]init];
    [homeFormatter setDateFormat:@"H"];
    
    NSDate *beginTime = [longFormatter dateFromString:time];;
    NSString *beginMonth = [homeFormatter stringFromDate:beginTime];
    return beginMonth;
}

+ (NSString *)monthtimeConversion:(NSString *)time
{
    NSDateFormatter *longFormatter = [[NSDateFormatter alloc]init];
    [longFormatter setDateFormat:@"HH:mm"];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc]init];
    [monthFormatter setDateFormat:@"m"];
    
    NSDate *beginTime = [longFormatter dateFromString:time];;
    NSString *beginDay = [monthFormatter stringFromDate:beginTime];
    return beginDay;
}


@end
