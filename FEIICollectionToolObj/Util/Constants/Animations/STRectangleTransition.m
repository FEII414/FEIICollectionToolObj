//
//  STRectangleTransition.m
//  dploffice
//
//  Created by shine-team2 on 2016/11/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "STRectangleTransition.h"
#import "CQNavController.h"
#import "CQMainTabBarController.h"
#import "ActivityViewController.h"

@implementation STRectangleTransition

- (instancetype)initWithTransitionType:(STRectangleTransitionType)type {
    
    if (self = [super init]) {
        _transitionType = type;
    }
    return self;
}

//动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.2;
}

//转场动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitionType) {
        case STRectangleTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case STRectangleTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}

//present动画
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UINavigationController *fromCtrl = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect cellRect;
    ActivityViewController *temp;
    if ([fromCtrl isKindOfClass:[CQMainTabBarController class]]) {
        NSArray<UIViewController *> *controllers = fromCtrl.viewControllers;
        CQNavController *navCtrl = (CQNavController *)controllers[2];
        
        ActivityViewController *activityCtrl = (ActivityViewController *)navCtrl.topViewController;
        cellRect = activityCtrl.cellFrame;
        temp = activityCtrl;
    } else {
        temp = fromCtrl.viewControllers.lastObject;
    }
    
    temp.maskView.hidden = NO;
    
    UIView *tempView = [fromCtrl.view snapshotViewAfterScreenUpdates:NO];
    tempView.tag = 1001;
    tempView.frame = fromCtrl.view.frame;
    
    fromCtrl.view.hidden = YES;
    
    toCtrl.view.frame = cellRect;
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:tempView];
    [containerView addSubview:temp.maskView];
    [containerView addSubview:toCtrl.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        temp.maskView.alpha = 0.6;
        tempView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            toCtrl.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

//dismiss动画
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UINavigationController *toCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromCtrl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect cellRect;
    ActivityViewController *temp;
    if ([toCtrl isKindOfClass:[CQMainTabBarController class]]) {
        NSArray<UIViewController *> *controllers = toCtrl.viewControllers;
        CQNavController *navCtrl = (CQNavController *)controllers[2];
        
        ActivityViewController *activityCtrl = (ActivityViewController *)navCtrl.topViewController;
        cellRect = activityCtrl.cellFrame;
        temp = activityCtrl;
    } else {
        temp = toCtrl.viewControllers.lastObject;
    }
    
    NSArray<UIGestureRecognizer *> *gestures = [fromCtrl.view gestureRecognizers];
    UIPanGestureRecognizer *panGesture;
    for (UIGestureRecognizer *gesture in gestures) {
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            panGesture = (UIPanGestureRecognizer *)gesture;
        }
    }

    if (!panGesture) {
        [transitionContext cancelInteractiveTransition];
    }
    CGPoint translation = [panGesture translationInView:panGesture.view];
    
    CGFloat xLocation = translation.x;
    CGFloat yLocation = translation.y > 0 ? translation.y : -translation.y;
    
    CGRect finalFrame;
    if (xLocation > yLocation) {
        finalFrame = CGRectMake(SCREEN_WIDTH - xLocation, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } else {
        if (translation.y > 0) {
            finalFrame = CGRectMake(0, yLocation, SCREEN_WIDTH, SCREEN_HEIGHT - yLocation);
        } else {
            finalFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - yLocation);
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [containerView viewWithTag:1001];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (xLocation < SCREEN_WIDTH * 1 / 3) {
        [transitionContext cancelInteractiveTransition];
    } else {
        temp.maskView.hidden = NO;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromCtrl.view.frame = finalFrame;
            temp.maskView.alpha = 0.0;
            tempView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            
            toCtrl.view.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end
