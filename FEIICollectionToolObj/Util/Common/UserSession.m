//
//  UserSession.m
//  dploffice
//
//  Created by Alex Wu on 16/3/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import "UserSession.h"
#import "UserSetModel.h"

static UserSession *session = nil;
@implementation UserSession

+(instancetype)shareAccount{
    if (!session) {
        session = [[self alloc] init];
    }
    
    return session;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        session = [super allocWithZone:zone];
        //从沙盒取得登录数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        session.uid = [defaults objectForKey:DPL_ID];
        session.rongToken = [defaults objectForKey:DPL_RONGTOKEN];
        session.token = [defaults objectForKey:DPL_TOKEN];
        session.userType = [defaults objectForKey:DPL_USERTYPE];
        session.discount = [defaults objectForKey:DPL_DISCOUNT];
        [defaults synchronize];
        
    });
    
    return session;
}

- (BOOL)isLogin
{

    return session.token.length > 0 && session.rongToken.length > 0;
}

- (void)saveAccountToSandBox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:session.token forKey:DPL_TOKEN];
    [defaults setObject:session.uid forKey:DPL_ID];
    [defaults setObject:session.rongToken forKey:DPL_RONGTOKEN];
    [defaults setObject:session.userType forKey:DPL_USERTYPE];
    [defaults setObject:session.discount forKey:DPL_DISCOUNT];
    [defaults synchronize];
}

- (void) clearToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey: DPL_TOKEN];
    [defaults removeObjectForKey: DPL_ID];
    [defaults removeObjectForKey: DPL_RONGTOKEN];
    [defaults removeObjectForKey: DPL_USERTYPE];
    [defaults removeObjectForKey: DPL_DISCOUNT];
    session.token = nil;
    session.rongToken = nil;
    session.userType = nil;
    session.uid = nil;
    session.discount = nil;
    [defaults synchronize];
}




+ (void)saveProfile:(UserSetModel *)user
{
   
    [DEFAULTS setObject:user.uid forKey:DPL_ID];
    [DEFAULTS setObject:user.rongToken forKey:DPL_RONGTOKEN];
    [DEFAULTS setObject:user.token forKey:DPL_TOKEN];
    [DEFAULTS setObject:user.userType forKey:DPL_USERTYPE];
    [DEFAULTS synchronize];
    //触发通知，当用户当前的页面是在关注页面的时候，进行通知切换
    [[NSNotificationCenter defaultCenter] postNotificationName:DPL_TOKEN object:nil];
}


+ (void)clearProfile
{
  
    [DEFAULTS removeObjectForKey:WX_ACCESS_TOKEN];
    [DEFAULTS removeObjectForKey:WX_OPEN_ID];
    [DEFAULTS removeObjectForKey:WX_REFRESH_TOKEN];
    [DEFAULTS synchronize];
}

+(UserSetModel *)getProfile{
    UserSetModel *userSet = [[UserSetModel alloc]init];
    
    userSet.uid =[DEFAULTS objectForKey:DPL_ID];
    userSet.rongToken =[DEFAULTS objectForKey:DPL_RONGTOKEN];
    userSet.token =[DEFAULTS objectForKey:DPL_TOKEN];
    userSet.userType =[DEFAULTS objectForKey:DPL_USERTYPE];
    
    return userSet;
}

+(BOOL)isAuth{
    
    return [DEFAULTS objectForKey:DPL_TOKEN]!=nil && [DEFAULTS objectForKey:DPL_RONGTOKEN]!=nil;
    
}


@end
