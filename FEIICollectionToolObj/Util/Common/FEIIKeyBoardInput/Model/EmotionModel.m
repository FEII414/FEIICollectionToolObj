//
//  EmotionModel.m
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import "EmotionModel.h"

@implementation FEIIEmotcion


@end

@implementation FEIIEmotcionGroup

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             
             @"emoticons":@"FEIIEmotcion"
             
             };
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"groupId" : @"id",
             @"nameCN" : @"group_name_cn",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
    
}

@end

@implementation FEIIEmotExtraModel


@end
