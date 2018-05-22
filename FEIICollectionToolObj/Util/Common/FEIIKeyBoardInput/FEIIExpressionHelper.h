//
//  FEIIExpressionHelper.h
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FEIIEmotcionGroup;

@interface FEIIExpressionHelper : NSObject

/// 表情 Array<YHEmoticonGroup> (实际应该做成动态更新的)
+ (NSArray<FEIIEmotcionGroup*> *)emoticonGroups;

+ (NSRegularExpression *)regexEmoticon;

/// 从 toolBarBundle / extraBundle 里获取图片 (有缓存)
+ (UIImage *)imageNamed:(NSString *)name;

@end
