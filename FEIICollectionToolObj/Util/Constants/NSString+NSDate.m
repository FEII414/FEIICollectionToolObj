//
//  NSString+NSDate.m
//  dploffice
//
//  Created by shine-team1 on 16/3/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import "NSString+NSDate.h"

@implementation NSString (NSDate)

+ (NSString *) compareCurrentTime:(NSString *)str
{
    
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    //设置时区
    form.locale = [NSLocale localeWithLocaleIdentifier:@"cn"];
    form.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [form dateFromString:str];
    
    //得到当前的时间差
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //然后进行时间的比较
    if(timeInterval < 60)
    {
        return [NSString stringWithFormat:@"刚刚"];
    }
    //分钟
    NSInteger minute = timeInterval / 60;
    if(minute < 60)
    {
        return [NSString stringWithFormat:@"%ld分钟之前",minute];
    }
    NSInteger hours = minute / 60;
    if(hours < 24)
    {
        return [NSString stringWithFormat:@"%ld小时之前",hours];
    }
    NSInteger day = hours / 24;
    
    if(day <= 1)
    {
        form.dateFormat = @"HH:mm";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"昨天 %@",oldtime];
    }
    else if(day < 7)
    {
        return [NSString stringWithFormat:@"%ld天之前",day];
    }
    else
    {
        form.dateFormat = @"yyyy-MM-dd";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"%@",oldtime];
    }
    return nil;
}

@end
