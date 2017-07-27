//
//  UIView+PBScrollAction.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/20.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "UIView+PBScrollAction.h"
#import <Pbind/Pbind.h>

@implementation UIView (PBScrollAction)

- (CGFloat)pb_scale {
    CGAffineTransform transform = self.transform;
    return transform.a;
}

- (void)setPb_scale:(CGFloat)scale {
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (CGFloat)pb_transformY {
    CGAffineTransform transform = self.transform;
    return transform.ty;
}

- (void)setPb_transformY:(CGFloat)ty {
    self.transform = CGAffineTransformMakeTranslation(0, ty);
}

@end
