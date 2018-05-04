////
////  CQHTTPTool.m
////  dploffice
////
////  Created by shine-team1 on 15/12/21.
////  Copyright © 2015年 com. All rights reserved.
////
//
//#import "CQHTTPTool.h"
//#import "CQBaseMethod.h"
//#import "ErrorResultModel.h"
//
//@implementation CQHTTPTool
//
//+(void)getWirhUrl:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
//{
//    [self getWirhUrl:url parms:parms group:NO success:success failture:failture];
//
//}
//
//+(void)postWirhUrl:(NSString*)url parms:(NSDictionary*)parms success:(void(^)(id json))success failture:(void(^)(id error))failture
//{
//    [self postWirhUrl:url parms:parms group:NO success:success failture:failture];
//
//}
//
//
//+(void)getWirhUrl:(NSString *)url parms:(NSDictionary *)parms group:(Boolean)isgroup success:(void (^)(id))success failture:(void (^)(id))failture{
//    
//    if (isgroup) {
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_group_enter(group);
//        [CQBaseMethod get:url parms:parms success:^(id json) {
//            if(success){
//                success(json);
//                dispatch_group_leave(group);
//                
//            }
//        } failture:^(id json) {
//            if(failture){
//                dispatch_group_leave(group);
//                failture(json);
//            }else{
//                ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//               [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//            }
//        }];
//    }else{
//        [CQBaseMethod get:url parms:parms success:^(id json) {
//            if(success){
//                success(json);
//            }
//        } failture:^(id json) {
//            if(failture){
//                failture(json);
//            }else{
//                ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//                [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//            }
//        }];
//    }
//    
//    
//}
//
//+(void)postWirhUrl:(NSString *)url parms:(NSDictionary *)parms group:(Boolean)isgroup success:(void (^)(id))success failture:(void (^)(id))failture{
//    if (isgroup) {
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_group_enter(group);
//        [CQBaseMethod post:url parms:parms success:^(id json) {
//            if(success){
//                success(json);
//                dispatch_group_leave(group);
//            }
//        } failture:^(id json) {
//            dispatch_group_leave(group);
//            if(failture){
//                failture(json);
//            }else{
//                ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//               [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//            }
//        }];
//    } else {
//        [CQBaseMethod post:url parms:parms success:^(id json) {
//            if(success){
//                success(json);
//            }
//        } failture:^(id json) {
//            if(failture){
//                failture(json);
//            }else{
//                ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//                [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//            }
//        }];
//    }
//}
//
//
//
//+(void)imgpostWirhUrl:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName  success:(void(^)(id json)) success failture:(void(^)(id json)) failture
//{
//    
//    [CQBaseMethod imgpost:url parms:parms data:imageData imageName:imageName success:^(id json) {
//        if(success){
//            success(json);
//        }
//    } failture:^(id json) {
//        if(failture){
//            failture(json);
//        }else{
//            ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//            [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//        }
//    }];
//}
//
////上传图片
//+(void)imgpost:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName tableCell:(CQInvitationIssueCell *)islogCell success:(void(^)(id json)) success failture:(void(^)(id json)) failture
//{
//    [CQBaseMethod imgpost:url parms:parms data:imageData imageName:imageName tableCell:islogCell success:^(id json) {
//        success(json);
//    } failture:^(id json) {
//        ErrorResultModel *error = [ErrorResultModel objectWithKeyValues:json];
//        [SVProgressHUD showErrorWithStatus:error.message==nil?@"系统错误！":error.message];
//    }];
//}
//
//
//
//@end

