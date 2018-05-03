//
//  ViewController.m
//  图片选择器
//
//  Created by shine-team1 on 16/1/25.
//  Copyright © 2016年 murdoch. All rights reserved.
//

#import "UITableView+Improve.h"

@implementation UITableView (Improve)
-(void)improveTableView
{
    self.tableFooterView = [[UIView alloc]init];  //删除多余的行
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {  //防止分割线显示不全
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
