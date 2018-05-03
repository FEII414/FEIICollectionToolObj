//
//  STInteractiveTransition.h
//  dploffice
//
//  Created by shine-team2 on 2016/11/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STInteractiveTransition : UIPercentDrivenInteractiveTransition

//是否处于交互中
@property (nonatomic, assign) BOOL isInteracting;

- (void)addPanGesture:(UIViewController *)controller;

@end
