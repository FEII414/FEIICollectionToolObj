//
//  STRectangleTransition.h
//  dploffice
//
//  Created by shine-team2 on 2016/11/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, STRectangleTransitionType) {
    STRectangleTransitionTypePresent = 0,
    STRectangleTransitionTypeDismiss
};

@interface STRectangleTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) STRectangleTransitionType transitionType;

- (instancetype)initWithTransitionType:(STRectangleTransitionType)type;

@end
