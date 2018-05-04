////
////  CQBaseMethod.m
////  dploffice
////
////  Created by shine-team1 on 15/12/23.
////  Copyright © 2015年 com. All rights reserved.
////
//
//#import "CQBaseMethod.h"
//#import "AFNetworking.h"
//#import "AFURLConnectionOperation.h"
//#import "UserSession.h"
//
//@implementation CQBaseMethod
//
//+(void)get:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
//{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 5.0f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserSession shareAccount].token] forHTTPHeaderField:@"Authorization"];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
//    [manager GET:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(success){
//            success(responseObject);  //   void(^)(id json)
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)operation.response;
//        NSLog(@"GET_statusCode--%d",httpResponse.statusCode);
//        if(failture){
//
//            if (error.code == -1001) {
//                [SVProgressHUD showErrorWithStatus:@"请求超时啦!"];
//                return ;
//            }
//            
//            if (httpResponse.statusCode == 401) { //未登录
//                [[UserSession shareAccount]clearToken];
//                return;
//            }
//            
//            if (httpResponse.statusCode == 402) { //到期时间
//                 [[NSNotificationCenter defaultCenter] postNotificationName:DIMISS_PAYCONTROLLER object:nil];
//                return;
//            }
//            if (httpResponse.statusCode == 405) { //无权限
//                [SVProgressHUD showErrorWithStatus:@"无权限"];
//                return;
//            }
//            
//            else
//            {
//                failture(operation.responseObject);
//                return ;
//            }
//            
//
//        }
//    
//    }];
//    
//}
//
//+(void)post:(NSString *)url parms:(NSDictionary *)parms success:(void (^)(id))success failture:(void (^)(id))failture
//{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 5.0f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserSession shareAccount].token] forHTTPHeaderField:@"Authorization"];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [manager POST:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if(success){
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)operation.response;
//                    NSLog(@"POST_statusCode--%d",httpResponse.statusCode);
//        if(failture){
//            
//            if (error.code == -1001) {
//                [SVProgressHUD showErrorWithStatus:@"请求超时啦!"];
//                return ;
//            }
//            
//            if (httpResponse.statusCode == 401) { //未登录
//                [[UserSession shareAccount]clearToken];
//                return;
//            }
//            
//            if (httpResponse.statusCode == 402) { //到期时间
//                [[NSNotificationCenter defaultCenter] postNotificationName:DIMISS_PAYCONTROLLER object:nil];
//                return;
//            }
//            if (httpResponse.statusCode == 405) { //无权限
//                [SVProgressHUD showErrorWithStatus:@"无权限"];
//                return;
//            }
//            
//            else
//            {
//                failture(operation.responseObject);
//                return ;
//            }
//            
//            
//        }
//    }];
//    
//}
//
//+(void)imgpost:(NSString*)url parms: (NSDictionary*)parms data: (NSData*)imageData imageName:(NSString *)imageName  success:(void(^)(id json)) success failture:(void(^)(id json)) failture{
//    
//    AFHTTPSessionManager *mang = [[AFHTTPSessionManager alloc]init];
//    mang.responseSerializer = [AFJSONResponseSerializer serializer];
//    [mang.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserSession shareAccount].token] forHTTPHeaderField:@"Authorization"];
//    [mang.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//    mang.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
//    [mang POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//    // 上传文件设置
//    [formData appendPartWithFileData:imageData name:@"filePath" fileName:imageName mimeType:@"image/jpg"];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//        // 成功
//
//        if(success){
//            success(responseObject);
//        }
//
//        NSLog(@"Success: %@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"Error: %@", error.userInfo[@"NSLocalizedDescription"]);
//        [SVProgressHUD showErrorWithStatus:@"上传失败"];
//        if(task){
//            failture(task);
//        }
//
//        
//    }];
//    
//    [mang setTaskDidSendBodyDataBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//        // bytesSent本次上传了多少字节
//        // totalBytesSent累计上传了多少字节
//        // totalBytesExpectedToSend文件有多大  应该上传多少
//        if (totalBytesSent*1.0/totalBytesExpectedToSend == 1.000000) {
//            dispatch_sync(dispatch_get_main_queue(), ^(){
//                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
//                [SVProgressHUD dismiss];
//            });
//        }
//        
//        NSLog(@"task %@ progress is %f ", task, totalBytesSent*1.0/totalBytesExpectedToSend);
//    }];
//
//}
//
//+ (void)imgpost:(NSString *)url parms:(NSDictionary *)parms data:(NSData *)imageData imageName:(NSString *)imageName tableCell:(CQInvitationIssueCell *)islogCell success:(void (^)(id))success failture:(void (^)(id))failture
//{
//    AFHTTPSessionManager *mang = [[AFHTTPSessionManager alloc]init];
//    mang.responseSerializer = [AFJSONResponseSerializer serializer];
//    [mang.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserSession shareAccount].token] forHTTPHeaderField:@"Authorization"];
//    [mang.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//    mang.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [mang POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        // 上传文件设置
//    [formData appendPartWithFileData:imageData name:@"filePath" fileName:imageName mimeType:@"image/jpg"];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//    
//        if(success){
//            //发出通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:IMAGE_OVER object:nil];
//            
//            success(responseObject);
//        }
//        
//        NSLog(@"Success: %@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if (error.code == -1001) {
//            [SVProgressHUD showErrorWithStatus:@"请求超时啦!"];
//            return ;
//        }
//        
//        [SVProgressHUD showErrorWithStatus:@"上传失败"];
//        if(task){
//            failture(task);
//        }
//    }];
//    
//    static int count;
//    count = 0;
//    [mang setTaskDidSendBodyDataBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//        // bytesSent本次上传了多少字节
//        // totalBytesSent累计上传了多少字节
//        // totalBytesExpectedToSend文件有多大  应该上传多少
//      
//        if (totalBytesSent*1.0/totalBytesExpectedToSend == 1.000000) {
//            
//            count++;
//            
//        }
//        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%lld%%(已完成%d张)",totalBytesSent*100/totalBytesExpectedToSend,count]];
//        NSLog(@"task %@ progress is %lld ", task, totalBytesSent*100/totalBytesExpectedToSend);
//    }];
//
//}
//
//@end

