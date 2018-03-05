//
//  PBAnimationAction.m
//  PBKit
//
//  Created by galen on 2018/3/3.
//

#import "PBAnimationAction.h"
#import "UIView+PBAnimation.h"
#import "PBAnimationMapper.h"
#import "PBAnimationInline.h"

@interface PBAnimationAction () <CAAnimationDelegate>

@end

@implementation PBAnimationAction

@pbaction(@"animate")
- (void)run:(PBActionState *)state {
    NSUInteger numberOfAnimations = self.anims.count;
    
    CFTimeInterval beginTime = 0;
    for (NSInteger index = 0; index < numberOfAnimations; index++) {
        NSDictionary *animConfig = self.anims[index];
        NSNumber *afterValue = animConfig[@"after"];
        NSNumber *durationValue = animConfig[@"duration"];
        BOOL after = [afterValue boolValue];
        NSTimeInterval duration = durationValue ? durationValue.floatValue : .25f;
        if (after) {
            beginTime += duration;
        }
        
        id target = animConfig[@"target"];
        if (target == nil) {
            continue;
        }
        
        PBMutableExpression *expression = [PBMutableExpression expressionWithString:target];
        if (expression == nil) {
            continue;
        }
        target = [expression valueWithData:nil target:nil owner:state.sender context:state.context];
        if (target == nil) {
            continue;
        }
        
        NSString *keyPath = animConfig[@"keyPath"];
        id toValue = nil;
        id byValue = animConfig[@"byValue"];
        if (byValue != nil) {
            if (![byValue respondsToSelector:@selector(floatValue)]) {
                continue;
            }
            
            BOOL failed = NO;
            id currentValue = [self valueForKeyPath:keyPath ofTarget:target failed:&failed];
            if (failed) {
                continue;
            }
            
            if (![currentValue respondsToSelector:@selector(floatValue)]) {
                continue;
            }
            
            toValue = @([currentValue floatValue] + [byValue floatValue]);
        } else {
            toValue = animConfig[@"toValue"];
            if ([toValue isKindOfClass:[NSString class]]) {
                expression = [PBMutableExpression expressionWithString:toValue];
                if (expression != nil) {
                    toValue = [expression valueWithData:nil target:nil owner:state.sender context:state.context];
                }
            }
        }
        if (toValue == nil) {
            continue;
        }
        
        void (^animations)(void) = ^{
            [self setValue:toValue toTarget:target forKeyPath:keyPath];
        };
        
        [UIView animateWithDuration:duration delay:beginTime options:0 animations:animations completion:nil];
        
        if (index == numberOfAnimations - 1) {
            beginTime += duration;
        }
    }
    
    if ([self hasNext:@"done"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(beginTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dispatchNext:@"done"];
        });
    }
}

- (void)setValue:(id)value toTarget:(id)target forKeyPath:(NSString *)targetKeyPath {
    if ([target respondsToSelector:@selector(pb_setValue:forKeyPath:)]) {
        [target pb_setValue:value forKeyPath:targetKeyPath];
    } else {
        [PBPropertyUtils setValue:value forKeyPath:targetKeyPath toObject:target failure:nil];
    }
}

- (id)valueForKeyPath:(NSString *)keyPath ofTarget:(id)target failed:(BOOL *)failed {
    if ([target respondsToSelector:@selector(pb_valueForKeyPath:)]) {
        return [target pb_valueForKeyPath:keyPath failure:^{
            *failed = YES;
        }];
    }
    return [PBPropertyUtils valueForKeyPath:keyPath ofObject:target failure:^{
        *failed = YES;
    }];
}

@end
