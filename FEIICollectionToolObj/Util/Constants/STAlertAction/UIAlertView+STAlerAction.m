//
//  UIAlertView+STAlerAction.m
//  dploffice
//
//  Created by shine-team1 on 16/7/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import "UIAlertView+STAlerAction.h"
#import <objc/runtime.h>

@implementation UIAlertView (STAlerAction)

static char key;



- (void)showWithBlock:(void(^)(NSInteger buttonIndex))block
{
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void(^block)(NSInteger buttonIndex);
    block = objc_getAssociatedObject(self, &key);
    objc_removeAssociatedObjects(self);
    if (block)
        block(buttonIndex);
}


@end
