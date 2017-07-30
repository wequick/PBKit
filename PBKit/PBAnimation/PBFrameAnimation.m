//
//  PBFrameAnimation.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBFrameAnimation.h"

@implementation PBFrameAnimation
{
    NSTimeInterval _duration;
    NSTimeInterval _delay;
    CADisplayLink *_link;
    CFTimeInterval _timestamp;
    void (^_animations)(CGFloat progress);
    void (^_complection)(BOOL finished);
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(CGFloat))animations {
    [self animateWithDuration:duration animations:animations completion:nil];
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(CGFloat))animations completion:(void (^)(BOOL))completion {
    [self animateWithDuration:duration delay:0.f animations:animations completion:completion];
}

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(CGFloat progress))animations completion:(void (^)(BOOL finished))completion {
    if (duration == 0) {
        if (animations) {
            animations(1.f);
        }
        if (completion) {
            completion(YES);
        }
        return;
    }
    
    PBFrameAnimation *anim = [[PBFrameAnimation alloc] init];
    anim->_duration = duration;
    anim->_delay = delay;
    anim->_animations = animations;
    anim->_complection = completion;
    [anim run];
}

- (instancetype)init {
    if (self = [super init]) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplay:)];
    }
    return self;
}

- (void)run {
    _timestamp = CACurrentMediaTime();
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)onDisplay:(CADisplayLink *)link {
    CGFloat progress = (CACurrentMediaTime() - _timestamp) / _duration;
    BOOL complected = NO;
    if (progress >= 1.f) {
        progress = 1.f;
        complected = YES;
        [link invalidate];
    }
    
    if (_animations) {
        _animations(progress);
    }
    
    if (complected) {
        if (_complection) {
            _complection(YES);
        }
    }
}

@end
