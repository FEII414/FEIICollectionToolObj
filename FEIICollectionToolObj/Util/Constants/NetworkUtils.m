//
//  NetworkUtils.m
//  dploffice
//
//  Created by shine-team2 on 16/3/31.
//  Copyright © 2016年 com. All rights reserved.
//

#import "NetworkUtils.h"
#import <Reachability/Reachability.h>

@implementation NetworkUtils

+ (NSInteger)networkStatus
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    return reachability.currentReachabilityStatus;
}

+ (BOOL)isNetworkExist
{
    return [self networkStatus] > 0;
}

@end
