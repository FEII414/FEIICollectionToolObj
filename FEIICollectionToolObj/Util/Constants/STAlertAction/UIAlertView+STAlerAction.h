//
//  UIAlertView+STAlerAction.h
//  dploffice
//
//  Created by shine-team1 on 16/7/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (STAlerAction)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showWithBlock:(void(^)(NSInteger buttonIndex)) block;




@end
