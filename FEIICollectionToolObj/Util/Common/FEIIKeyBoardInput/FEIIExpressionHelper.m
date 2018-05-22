//
//  FEIIExpressionHelper.m
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import "FEIIExpressionHelper.h"
#import "EmotionModel.h"

@implementation FEIIExpressionHelper

+ (NSBundle *)emoticonBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"KeyBoardInput" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    });
    return bundle;
}

+ (NSArray<FEIIEmotcionGroup*> *)emoticonGroups {
    static NSMutableArray *groups;
    static dispatch_once_t onceToken;
    static NSMutableArray *returnGroups;
    dispatch_once(&onceToken, ^{
        NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"KeyBoardInput" ofType:@"bundle"];
        NSString *emoticonPlistPath = [emoticonBundlePath stringByAppendingPathComponent:@"emoticons.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:emoticonPlistPath];
        NSArray *packages = plist[@"packages"];
        
        if (!groups) {
            groups = [[NSMutableArray alloc]init];
        }
        
        for (NSDictionary *dicTemp in packages) {
            
            FEIIEmotcionGroup *groupModel = [FEIIEmotcionGroup mj_objectWithKeyValues:dicTemp];
            [groups addObject:groupModel];
            
        }
        
        returnGroups = [[NSMutableArray alloc]init];
//        NSMutableDictionary *groupDic = [NSMutableDictionary new];
        for (int i = 0, max = (int)groups.count; i < max; i++) {
            FEIIEmotcionGroup *group = groups[i];
            if (group.groupId.length == 0) {
                [groups removeObjectAtIndex:i];
                i--;
                max--;
                continue;
            }
            NSString *path = [emoticonBundlePath stringByAppendingPathComponent:group.groupId];
            NSString *infoPlistPath = [path stringByAppendingPathComponent:@"info.plist"];
            NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
            group = [FEIIEmotcionGroup mj_objectWithKeyValues:info];
            for (FEIIEmotcion *emotcionM in group.emoticons) {
                
                emotcionM.group = group;
                
            }
            if (group.emoticons.count == 0) {
                i--;
                max--;
                continue;
            }
            [returnGroups addObject:group];
//            groupDic[group.groupId] = group;
    
        }
        
    });
    return returnGroups;
}

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (!name) return nil;
    UIImage *image = nil;
    return image;
}

@end
