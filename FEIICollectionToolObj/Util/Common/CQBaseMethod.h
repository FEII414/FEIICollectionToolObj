//
//  CQBaseMethod.h
//  dploffice
//
//  Created by shine-team1 on 15/12/23.
//  Copyright © 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQBaseMethod : NSObject

//网络请求的GET方法
+(void)get:(NSString*)url parms: (NSDictionary*)parms success:(void(^)(id json)) success failture:(void(^)(id json)) failture;
//网络请求的POST方法
+(void)post:(NSString*)url parms: (NSDictionary*)parms success:(void(^)(id json)) success failture:(void(^)(id json)) failture;
//上传图片
+(void)imgpost:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName  success:(void(^)(id json)) success failture:(void(^)(id json)) failture;

//上传图片cell加载
//上传图片
+(void)imgpost:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName tableCell:(CQInvitationIssueCell *)islogCell success:(void(^)(id json)) success failture:(void(^)(id json)) failture;
@end
