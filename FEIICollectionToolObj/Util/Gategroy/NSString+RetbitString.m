//
//  NSString+RetbitString.m
//  officecamp
//
//  Created by shine-team1 on 16/4/12.
//  Copyright © 2016年 st. All rights reserved.
//

#import "NSString+RetbitString.h"

@implementation NSString (RetbitString)


/**
 *  随机生成32位数
 *
 *  @return 返回一个32位字符串
 */
+(NSString *)ret32bitString
{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

@end
