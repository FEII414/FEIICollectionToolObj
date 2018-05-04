//
//  UIButton+ImageWithLabel.h
//  dploffice
//
//  Created by LiuRivers on 16/2/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (ImageWithLabel)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType imageEdgeInset:(UIEdgeInsets) imageInset titleEdgeInset:(UIEdgeInsets) titleInset;


- (void) setImage:(UIImage *)image withTittle:(NSString *)tittle withBackgloudColor:(UIColor *)color forState:(UIControlState)stateType;

@end
