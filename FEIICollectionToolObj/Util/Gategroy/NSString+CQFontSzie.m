//
//  NSString+CQFontSzie.m
//  deLiPei
//
//  Created by shine-team1 on 15/12/9.
//  Copyright © 2015年 dlp. All rights reserved.
//

#import "NSString+CQFontSzie.h"

@implementation NSString (CQFontSzie)

- (CGSize)fontSizeWithMaxSize:(CGSize)maxSize Attribute:(NSDictionary *)att
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
}
@end
