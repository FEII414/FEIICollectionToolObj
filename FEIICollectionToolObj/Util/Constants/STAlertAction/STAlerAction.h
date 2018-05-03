//
//  STAlerAction.h
//  dploffice
//
//  Created by shine-team1 on 16/7/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STAlerAction : NSObject

/**
 @brief  模式对话框，选择一项（UIAlertView与与UIAlertController封装，根据不同ios版本对应选择调用方法）
 @param title        标题
 @param msg          提示内容
 @param block        返回点击的按钮index,按照buttonsStatement按钮的顺序，从0开始
 @param cancelString 取消按钮 文本，必须以nil结束
 */
+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)msg chooseBlock:(void (^)(NSInteger buttonIdx))block  buttonsStatement:(NSString*)cancelString, ...;

//增加延时消失入口



/**
 @brief  显示UIActionSheet模式对话框，UIActionSheet与UIAlertController封装，根据不同ios版本对应选择调用方法。
 @param title                  标题
 @param message                消息内容,大于ios8.0才会显示
 @param block                  返回block,buttonIdx:cancelString,destructiveButtonTitle分别为0、1,
 otherButtonTitle从后面开始，如果destructiveButtonTitle没有，buttonIndex1开始，反之2开始
 @param cancelString           取消文本
 @param destructiveButtonTitle 特殊标记按钮，默认红色文字显示
 @param otherButtonTitle       其他选项,必须以nil结束
 */
+ (void)showActionSheetWithTitle:(NSString*)title message:(NSString*)message chooseBlock:(void (^)(NSInteger buttonIdx))block
               cancelButtonTitle:(NSString*)cancelString destructiveButtonTitle:(NSString*)destructiveButtonTitle otherButtonTitle:(NSString*)otherButtonTitle,...;



@end
