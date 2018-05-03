//
//  STPageCollectionCell.m
//  officecamp
//
//  Created by shine-team1 on 16/6/13.
//  Copyright © 2016年 st. All rights reserved.
//

#import "STPageCollectionCell.h"

@implementation STPageCollectionCell

- (void)setIndexController:(UIViewController *)indexController{
    
    [_indexController.view removeFromSuperview];
    _indexController = indexController;
    [self.contentView addSubview:_indexController.view];
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _indexController.view.frame = self.bounds;
}

@end
