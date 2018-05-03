//
//  CQHTTPTool.h
//  dploffice
//
//  Created by shine-team1 on 15/12/21.
//  Copyright © 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CQInvitationIssueCell.h"


@interface CQHTTPTool : NSObject

+(void)getWirhUrl:(NSString*)url parms:(NSDictionary*)parms success:(void(^)(id json))success failture:(void(^)(id error))failture;

+(void)postWirhUrl:(NSString*)url parms:(NSDictionary*)parms success:(void(^)(id json))success failture:(void(^)(id error))failture;

+(void)getWirhUrl:(NSString *)url parms:(NSDictionary *)parms group:(Boolean)isgroup success:(void (^)(id))success failture:(void (^)(id))failture;

+(void)postWirhUrl:(NSString *)url parms:(NSDictionary *)parms group:(Boolean)isgroup success:(void (^)(id))success failture:(void (^)(id))failture;

+(void)imgpostWirhUrl:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName success:(void(^)(id json)) success failture:(void(^)(id json)) failture;

+(void)imgpost:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName: (NSString *)imageName tableCell:(CQInvitationIssueCell *)islogCell success:(void(^)(id json)) success failture:(void(^)(id json)) failture;

@end
