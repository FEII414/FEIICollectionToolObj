//
//  NSString+NSDate.h
//  dploffice
//
//  Created by shine-team1 on 16/3/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSDate)

/**
 *  返回多少分钟之前
 *
 *  @param str 传入时间字符串
 *
 *  @return XX时间
 */
+ (NSString *) compareCurrentTime:(NSString *)str;

@end
