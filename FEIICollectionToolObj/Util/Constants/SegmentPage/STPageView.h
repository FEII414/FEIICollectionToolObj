//
//  STPageView.h
//  officecamp
//
//  Created by shine-team1 on 16/6/13.
//  Copyright © 2016年 st. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPageView;

@protocol STPageContentViewDelegate <NSObject>

@optional

- (void)pageContentView:(STPageView *)pageContentView didClickBtnIndex:(NSInteger)index;

@end

@interface STPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemsArray:(NSArray *)itemsArray;

@property (nonatomic, weak) id<STPageContentViewDelegate> delegate;


@property (nonatomic, assign) int index;

@end
