//
//  UIImage+Util.h
//  iosapp
//
//  Created by ChanAetern on 2/13/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;
- (UIImage *)cropToRect:(CGRect)rect;
-(UIImage *)converImageWithWidth:(CGFloat)width height:(CGFloat)height;
- (UIImage *) scaleImage:(CGSize) size;

- (UIImage *) scaleImageByWidthAndMaxHeight: (CGFloat) width maxHeight:(CGFloat) maxHeight;
@end
