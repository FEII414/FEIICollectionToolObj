//
//  UIButton+ImageWithLabel.m
//  dploffice
//
//  Created by LiuRivers on 16/2/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import "UIButton+ImageWithLabel.h"

#define padding 5

@implementation UIButton (ImageWithLabel)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType imageEdgeInset:(UIEdgeInsets)imageInset titleEdgeInset:(UIEdgeInsets)titleInset {
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:imageInset];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont: [UIFont systemFontOfSize:16]];
    [self.titleLabel setTextColor: [UIColor whiteColor]];
    [self setTitleEdgeInsets: titleInset];
    [self setTitle:title forState:stateType];
}


- (void) setImage:(UIImage *)image withTittle:(NSString *)tittle withBackgloudColor:(UIColor *)color forState:(UIControlState)stateType{
 
    [self setImage:image forState:stateType];
    
    NSLog(@"long = %f", self.titleLabel.bounds.size.width);
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 2)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 35)];
    
    if (color) {
        [self setBackgroundColor:color];
    }else{
        [self setBackgroundColor:[UIColor colorWithRed:51/255.0 green:156/255.0 blue:255/255.0 alpha:1]];
    }
    
    [self.titleLabel setFont: [UIFont systemFontOfSize:13]];
    [self.titleLabel setTextColor: [UIColor whiteColor]];
    
    
}





@end
