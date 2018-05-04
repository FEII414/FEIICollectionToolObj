////
////  UserSession.h
////  dploffice
////
////  Created by Alex Wu on 16/3/8.
////  Copyright © 2016年 com. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "UserSetModel.h"
//
//@interface UserSession : NSObject
//
//+ (void)saveProfile:(UserSetModel *)user;
//
//+ (void)clearProfile;
//
//+(UserSetModel *)getProfile;
//
//+(BOOL)isAuth;
//
//
////用户信息改为使用单例进行保存，方便调用
//
///**
// *  单例，用户登录信息
// */
//+ (instancetype)shareAccount;
//
//
///**
// 判断是否登录
// */
//- (BOOL)isLogin;
//
//
///**
// 保持持久信息
// */
//- (void)saveAccountToSandBox;
//
//
///**
// 清除token
// */
//- (void) clearToken;
//
//@property (nonatomic, copy) NSString *uid;
//@property (nonatomic, copy) NSString *userType;
//@property (nonatomic, copy) NSString *token;
//@property (nonatomic, copy) NSString *userName;
//@property (nonatomic, copy) NSString *rongToken;
//@property (nonatomic, copy) NSString *discount;
//
//@end

