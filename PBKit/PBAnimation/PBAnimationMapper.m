//
//  PBAnimationMapper.m
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import "PBAnimationMapper.h"
#import "UIView+PBAnimation.h"

@implementation PBAnimationMapper

+ (void)load {
    [PBValueParser registerEnums:@{@"repeatForever": @(HUGE_VALF),
                                   @"PI": @(M_PI),
                                   @"PI_2": @(M_PI_2),
                                   @"PI_4": @(M_PI_4),
                                   @"2_PI": @(M_2_PI)}];
    [Pbind registerPlistReloader:^(UIView *rootView, UIView *view, NSString *changedPlist, BOOL *stop) {
        NSArray *animPlistNames = view.pb_anims;
        if (animPlistNames != nil && [animPlistNames containsObject:changedPlist]) {
            [view pb_reloadAnim:changedPlist];
            return YES;
        }
        return NO;
    }];
}

- (Class)animationClass {
    NSString *clazz = self.clazz;
    if (clazz == nil) {
        if (self.type != nil && self.type.length >= 2) {
            clazz = [NSString stringWithFormat:@"CA%c%@Animation", toupper([self.type characterAtIndex:0]), [self.type substringFromIndex:1]];
        } else {
            return [CABasicAnimation class];
        }
    }
    
    return NSClassFromString(clazz);
}

- (void)initPropertiesForTarget:(id)target {
    NSString *keyPath = [_viewProperties constantForKey:@"keyPath"];
    BOOL requiresAngleValue = [keyPath hasPrefix:@"transform.rotation"];
    [super initPropertiesForTarget:target transform:^id(NSString *key, id value) {
        if ([key isEqualToString:@"timingFunction"]) {
            value = [self timingFunctionFromString:value];
        } else if ([key isEqualToString:@"timingFunctions"]) {
            value = [self timingFunctionsFromArray:value];
        } else if (requiresAngleValue) {
            if ([key isEqualToString:@"fromValue"] || [key isEqualToString:@"toValue"]) {
                value = @([value floatValue] * M_PI / 180.f);
            } else if ([key isEqualToString:@"values"] && [value isKindOfClass:[NSArray class]]) {
                NSMutableArray *values = [NSMutableArray arrayWithCapacity:[value count]];
                for (id temp in value) {
                    NSNumber *rad = @([temp floatValue] * M_PI / 180.f);
                    [values addObject:rad];
                }
                value = values;
            }
        }
        return value;
    }];
}

#pragma mark - Helper

- (CAMediaTimingFunction *)timingFunctionFromString:(NSString *)aString {
    if (![aString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if ([aString isEqualToString:@"linear"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    } else if ([aString isEqualToString:@"easeIn"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    } else if ([aString isEqualToString:@"easeOut"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    } else if ([aString isEqualToString:@"easeInOut"]) {
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    } else {
        UIEdgeInsets points = UIEdgeInsetsFromString(aString);
        if (!UIEdgeInsetsEqualToEdgeInsets(points, UIEdgeInsetsZero)) {
            return [CAMediaTimingFunction functionWithControlPoints:points.top :points.left :points.bottom :points.right];
        }
    }
    
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

- (NSArray *)timingFunctionsFromArray:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *funcs = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSString *name in array) {
        CAMediaTimingFunction *func = [self timingFunctionFromString:name];
        if (func != nil) {
            [funcs addObject:func];
        }
    }
    return funcs;
}

@end
