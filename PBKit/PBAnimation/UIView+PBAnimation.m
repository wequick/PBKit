//
//  UIView+PBAnimation.m
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import "UIView+PBAnimation.h"
#import "UIView+Pbind.h"
#import "PBInline.h"
#import "PBAnimationMapper.h"

@implementation UIView (PBAnimation)

- (void)setPb_anims:(NSArray *)anims {
    [self setValue:anims forAdditionKey:@"pb_anims"];
    
    for (NSString *animPlist in anims) {
        [self pb_loadAnim:animPlist];
    }
}

- (NSArray *)pb_anims {
    return [self valueForAdditionKey:@"pb_anims"];
}

- (void)pb_loadAnim:(NSString *)animPlist {
    NSDictionary *animConfig = PBPlist(animPlist);
    if (animConfig != nil) {
        PBAnimationMapper *animMapper = [PBAnimationMapper mapperWithDictionary:animConfig];
        Class animClass = [animMapper animationClass];
        if (animClass == nil) {
            return;
        }
        
        CAAnimation *anim = [animClass animation];
        [animMapper setPropertiesToObject:anim transform:^id(NSString *key, id value) {
            if ([key isEqualToString:@"timingFunction"]) {
                value = [self timingFunctionFromString:value];
            } else if ([key isEqualToString:@"timingFunctions"]) {
                value = [self timingFunctionsFromArray:value];
            }
            return value;
        }];
        
        [self.layer addAnimation:anim forKey:animPlist];
    }
}

- (void)pb_reloadAnim:(NSString *)animPlist {
    [self.layer removeAnimationForKey:animPlist];
    [self pb_loadAnim:animPlist];
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
