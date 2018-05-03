//
//  UIView+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-17.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "UIView+Util.h"
#import <GPUImage/GPUImage.h>

@implementation UIView (Util)

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (UIImage *)updateBlur
{
    UIImage *screenshot = [self convertViewToImage];
    GPUImageiOSBlurFilter *blurFilter = [GPUImageiOSBlurFilter new];
    blurFilter.saturation = 1.0;
    blurFilter.rangeReductionFactor = 0.5;
    
    UIImage *blurImage = [blurFilter imageByFilteringImage:screenshot];
    
    return blurImage;
}

- (void) tapHideKeyBoard
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    [self addGestureRecognizer:gesture];
}

- (void) hideKeyBoard:(UITapGestureRecognizer *) gesture
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void) scrollHideKeyBoard
{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    gesture.direction = UISwipeGestureRecognizerDirectionDown;
//    gesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer: gesture];
}

@end
