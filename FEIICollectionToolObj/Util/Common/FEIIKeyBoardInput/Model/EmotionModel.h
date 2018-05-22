//
//  EmotionModel.h
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEIIEmotcionGroup;
typedef NS_ENUM(NSInteger, FEIIEmotionType){
    
    FEIIEmotionTypeImage = 0,  //图片表情
    FEIIEmotionTypeEmoji = 1,  //Emoji表情
    
};

@interface FEIIEmotcion : NSObject

@property (nonatomic, copy) NSString *chs;  //例如[吃惊]
@property (nonatomic, copy) NSString *gif;  //feii.gif;
@property (nonatomic, copy) NSString *png;  //feii.png;
@property (nonatomic, copy) NSString *code; //0x123212;
@property (nonatomic, assign) FEIIEmotionType type;
@property (nonatomic, weak) FEIIEmotcionGroup *group;

@end


//表情组
@interface FEIIEmotcionGroup : NSObject

@property (nonatomic, copy) NSString *groupId;  //com.ln.default
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, copy) NSString *nameCN;  //中文名
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSMutableArray<FEIIEmotcion*> *emoticons;

@end

//
@interface FEIIEmotExtraModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon_nor;
@property (nonatomic, copy) NSString *icon_sel;

@end
