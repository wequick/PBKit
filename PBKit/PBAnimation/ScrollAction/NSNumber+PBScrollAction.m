//
//  NSNumber+PBScrollAction.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/20.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "NSNumber+PBScrollAction.h"

@implementation NSNumber (PBScrollAction)

+ (id)valueWithProgress:(double)progress fromValue:(id)fromValue toValue:(id)toValue {
    if ([fromValue isEqualToNumber:toValue]) {
        return fromValue;
    }
    
    double from = [fromValue doubleValue];
    double to = [toValue doubleValue];
    return @(from + progress * (to - from));
}

@end
