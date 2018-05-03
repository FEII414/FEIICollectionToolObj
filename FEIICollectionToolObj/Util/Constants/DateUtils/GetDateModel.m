//
//  GetDateModel.m
//  officecamp
//
//  Created by shine-team1 on 16/4/17.
//  Copyright © 2016年 st. All rights reserved.
//

#import "GetDateModel.h"

@implementation GetDateModel

- (void) clearDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:DEFAULT_CURRENTDATE];
//    [defaults removeObjectForKey:@"addComps"];
    [defaults synchronize];
}

-(void)saveDateToSandBoxStr:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:DEFAULT_CURRENTDATE];
//    [defaults setObject:self.addComps forKey:@"addComps"];
    [defaults synchronize];
}

-(NSString *)backDateStr
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:DEFAULT_CURRENTDATE];
}

@end
