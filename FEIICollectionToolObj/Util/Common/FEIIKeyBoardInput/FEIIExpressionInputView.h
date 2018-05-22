//
//  FEIIExpressionInputView.h
//  jdyk
//
//  Created by Lieniu03 on 2018/5/21.
//  Copyright © 2018年 Lieniu03. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEIIExpressionInputViewDelegate <NSObject>

@optional

- (void)emoticonInputDidTapText:(NSString *)text;

- (void)emoticonInputDidTapBackspace;

@end

/// 表情键盘
@interface FEIIExpressionInputView : UIView

@property (nonatomic, weak) id<FEIIExpressionInputViewDelegate> delegate;
@property (nonatomic, strong) UITextView *textView;

+ (instancetype)sharedView;

@end
