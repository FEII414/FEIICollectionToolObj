//
//  StatusAndType.h
//  dploffice
//
//  Created by Alex Wu on 16/3/12.
//  Copyright © 2016年 com. All rights reserved.
//

//用户类型
typedef NS_ENUM(NSInteger, OwnerType) {
    OwnerTypePersonal,
    OwnerTypeEnterprise
};

//帖子状态
typedef NS_ENUM(NSInteger, PostStatus) {
    PostStatusEnable,
    PostStatusDisable
};

//群组状态
typedef NS_ENUM(NSInteger, TribeStatus) {
    TribeStatusEnable,
    TribeStatusDisable
};

//加入群组状态
typedef NS_ENUM(NSInteger, JoinStatus) {
    JoinStatusIn,
    JoinStatusNotIn
};



