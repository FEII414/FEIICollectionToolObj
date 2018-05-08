//
//  FEIIStringSizeTool.m
//  lnyxs
//
//  Created by Lieniu03 on 2018/5/8.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import "FEIIStringSizeTool.h"

@implementation FEIIStringSizeTool

//单行文本宽度
+ (CGFloat)sizeString:(NSString*)string font:(CGFloat)fontFloat{
    
    UIFont *font = [UIFont systemFontOfSize:fontFloat];
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size.width;
    
}

@end
