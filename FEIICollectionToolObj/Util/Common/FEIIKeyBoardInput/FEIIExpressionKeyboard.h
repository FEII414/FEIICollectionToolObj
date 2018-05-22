//
//  FEIIExpressionKeyboard.h
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FEIIExpressionKeyboard;
@protocol FEIIExpressionKeyboardDelegate <NSObject>


@optional
//根据键盘是否弹起，设置tableView frame
- (void)keyboard:(FEIIExpressionKeyboard *)keyBoard changeDuration:(CGFloat)durtaion;
//选择了“+”内容
- (void)didSelectExtraItem:(NSString *)itemName;

@end

@interface FEIIExpressionKeyboard : UIView

@property (nonatomic, assign) int maxNumberOfRowsToShow;//最大显示行

//初始化
- (instancetype)initWithViewController:(UIViewController <FEIIExpressionKeyboardDelegate>*)viewController;

//结束编辑
- (void)endEditing;

@end
