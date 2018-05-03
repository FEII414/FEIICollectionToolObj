//
//  STInteractiveTransition.m
//  dploffice
//
//  Created by shine-team2 on 2016/11/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "STInteractiveTransition.h"

@interface STInteractiveTransition()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL shouldComplete;

@property (nonatomic, strong) UIViewController *presentedController;

@end

@implementation STInteractiveTransition

- (void)addPanGesture:(UIViewController *)controller {
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    self.presentedController = controller;
    [controller.view addGestureRecognizer:panGesture];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    UIView *view = recognizer.view;
    CGFloat targetPoint = 0.1;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            {
                self.isInteracting = YES;
            }
            break;
        case UIGestureRecognizerStateChanged:
            {
                NSLog(@"state changed");
                CGFloat fraction;
                
                CGFloat xTrans = translation.x;
                CGFloat yTrans = translation.y > 0 ? translation.y : -translation.y;
                
                if (xTrans > yTrans) {
                    fraction = translation.x / SCREEN_WIDTH;
                    [self forbitTableview:view];
                } else {
                    fraction = yTrans / SCREEN_HEIGHT;
                    //判断是否存在UItableView,存在则返回该view，没有返回nil
                    UITableView *result = [self fetchChildTableview:view];
                    if (result) {
                         result.contentSize.height;
                    } else {
                        
                    }
                }
                
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                
                if ([view isKindOfClass:[UITableView class]]) {
                    UITableView *temp = (UITableView *)view;
                    CGPoint offset = temp.contentOffset;
                    //如果偏移量超出上边界或者下边界
                    self.shouldComplete = (fraction > targetPoint) && (offset.y <= -30.0f);
                    //&& (offset.y <= -20.0f || offset.y - temp.contentSize.height >= 20.0f);
                } else {
                    self.shouldComplete = (fraction > targetPoint);
                }
                
                [self updateInteractiveTransition:fraction];
                
                if (self.shouldComplete) {
                    self.shouldComplete = NO;
                    [self.presentedController dismissViewControllerAnimated:YES completion:nil];
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            {
                self.isInteracting = NO;
//                [self unForbit:view];
                if (!self.shouldComplete || recognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                } else {
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            break;
    }
}

- (CGFloat)completionSpeed {
    
    return 1 - self.percentComplete;
}

- (void)forbitTableview:(UIView *)parent {
    
    if (parent) {
        NSArray<UIView *> *childs = [parent subviews];
        for (UIView *child in childs) {
            if ([child isKindOfClass:[UITableView class]]) {
                ((UITableView *)child).bounces = NO;
                ((UITableView *)child).scrollEnabled = NO;
            }
        }
    }
}

- (void)unForbit:(UIView *)parent {
    
    if (parent) {
        NSArray<UIView *> *childs = [parent subviews];
        for (UIView *child in childs) {
            if ([child isKindOfClass:[UITableView class]]) {
                ((UITableView *)child).bounces = YES;
                ((UITableView *)child).scrollEnabled = YES;
            }
        }
    }
}

- (UITableView *)fetchChildTableview:(UIView *)parent {
    
    UITableView *result = nil;
    if (parent) {
        NSArray<UIView *> *childs = [parent subviews];
        for (UIView *child in childs) {
            if ([child isKindOfClass:[UITableView class]]) {
                result = (UITableView *)child;
                break;
            }
        }
    }
    
    return result;
}

#pragma mark /******************* gesture delegate *********************/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        
        return YES;
    }
    return NO;
}
@end
