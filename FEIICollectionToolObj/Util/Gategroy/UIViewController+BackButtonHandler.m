//
//  UIButton+BackButtonHandler
//  dploffice
//
//  Created by LiuRivers on 16/2/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"

@implementation UIViewController (BackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

	BOOL shouldPop = YES;
	UIViewController* vc = [self topViewController];
	if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
		shouldPop = [vc navigationShouldPopOnBackButton];
	}

	if(shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	} else {
		for(UIView *subview in [navigationBar subviews]) {
			if(0. < subview.alpha && subview.alpha < 1.) {
				[UIView animateWithDuration:.25 animations:^{
					subview.alpha = 1.;
				}];
			}
		}
	}

	return NO;
}

@end
