//
//  PBTransitionActionMapper.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "PBTransitionActionMapper.h"

@interface PBTransitionActionMapper () <CAAnimationDelegate>

@end

@implementation PBTransitionActionMapper
{
    void (^_complection)(BOOL);
}

- (void)setPropertiesWithDictionary:(NSDictionary *)dictionary {
    _duration = .25f;
    [super setPropertiesWithDictionary:dictionary];
}

- (CGFloat)actionDuration {
    if (![self canAnimate]) {
        return 0.f;
    }
    return _duration + _delay;
}

- (void)animateWithComplection:(void (^)(BOOL))aComplection {
    if (![self canAnimate]) {
        return;
    }
    
    if ([self shouldUseBasicAnimation]) {
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = _keyPath;
        anim.fromValue = _fromValue;
        anim.toValue = _toValue;
        anim.byValue = _byValue;
        anim.duration = _duration;
        anim.beginTime = CACurrentMediaTime() + _delay;
        anim.removedOnCompletion = YES;
        anim.delegate = self;
        
        _complection = aComplection;
        
        [_target.layer addAnimation:anim forKey:_name];
        return;
    }
    
    if (_fromValue != nil) {
        [_target pb_setValue:_fromValue forKeyPath:_keyPath];
    }
    
    dispatch_block_t animations = ^ {
        [_target pb_setValue:_toValue forKeyPath:_keyPath];;
    };
    void (^complection)(BOOL) = ^(BOOL finished) {
        if (aComplection) {
            aComplection(finished);
        }
    };
    if ([self canPerformsAnimateWithDuration]) {
        [UIView animateWithDuration:_duration delay:_delay options:_options animations:animations completion:complection];
    } else {
        [UIView transitionWithView:_target duration:_duration options:_options animations:animations completion:complection];
    }
}

- (BOOL)canAnimate {
    if (_target == nil || _keyPath == nil) {
        return NO;
    }
    
    if (_toValue == nil && _byValue == nil) {
        return NO;
    }
    
    return [_target isKindOfClass:[UIView class]];
}

- (BOOL)shouldUseBasicAnimation {
    return [_keyPath hasPrefix:@"transform."];
}

- (BOOL)canPerformsAnimateWithDuration {
    if ([_toValue isKindOfClass:[UIColor class]]) {
        return NO;
    }
    return YES;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_complection) {
        _complection(flag);
    }
}

@end
