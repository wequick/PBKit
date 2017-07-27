//
//  UIViewController+PBTransition.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "UIViewController+PBTransition.h"
#import <objc/runtime.h>

@implementation UIViewController (PBTransition)

static NSString *kEnterActionsKey;
static NSString *kLeaveActionsKey;

- (NSArray *)pb_enterActions {
    return objc_getAssociatedObject(self, &kEnterActionsKey);
}

- (void)setPb_enterActions:(NSArray *)actions {
    objc_setAssociatedObject(self, &kEnterActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)pb_leaveActions {
    return objc_getAssociatedObject(self, &kLeaveActionsKey);
}

- (void)setPb_leaveActions:(NSArray *)actions {
    objc_setAssociatedObject(self, &kLeaveActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
