//
//  UIActionSheet+STAlerAction.h
//  dploffice
//
//  Created by shine-team1 on 16/7/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (STAlerAction)<UIActionSheetDelegate>

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;


@end
