//
//  UIColor+PBScrollAction.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/20.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "UIColor+PBScrollAction.h"

@implementation UIColor (PBScrollAction)

+ (id)valueWithProgress:(double)progress fromValue:(id)fromValue toValue:(id)toValue {
    UIColor *fromColor = fromValue;
    UIColor *toColor = toValue;
    
    CGFloat fromR, fromG, fromB, fromA;
    CGFloat toR, toG, toB, toA;
    CGFloat r, g, b, a;
    CGFloat p1 = (1.f - progress);
    CGFloat p2 = progress;
    
    [fromColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromA];
    [toColor getRed:&toR green:&toG blue:&toB alpha:&toA];
    
    r = p1 * fromR + p2 * toR;
    g = p1 * fromG + p2 * toG;
    b = p1 * fromB + p2 * toB;
    a = p1 * fromA + p2 * toA;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
