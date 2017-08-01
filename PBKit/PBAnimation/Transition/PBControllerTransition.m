//
//  PBTransition.m
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import "PBControllerTransition.h"
#import "PBTransitionActionMapper.h"
#import "UIViewController+PBTransition.h"

@interface PBTransitionContext : UIView

@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, weak) UIViewController *toVC;
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toView;
@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> baseContext;

@end

@implementation PBTransitionContext

- (UIView *)viewWithAlias:(NSString *)alias {
    return [self valueForKey:alias];
}

@end

@implementation PBControllerTransition
{
    PBTransitionActionMapper *_headerMapper;
    PBTransitionContext *_context;
}

+ (instancetype)enterTransitionForViewController:(UIViewController *)viewController {
    return [self transitionWithActions:viewController.pb_enterActions];
}

+ (instancetype)leaveTransitionForViewController:(UIViewController *)viewController {
    return [self transitionWithActions:viewController.pb_leaveActions];
}

+ (instancetype)transitionWithActions:(NSArray *)actions {
    if (actions.count == 0) {
        return nil;
    }
    
    PBControllerTransition *transition = [[PBControllerTransition alloc] init];
    PBTransitionActionMapper *headerMapper = nil;
    PBTransitionActionMapper *previousMapper = nil;
    for (NSString *action in actions) {
        NSDictionary *actionInfo = PBPlist(action);
        if (actionInfo == nil) {
            continue;
        }
        
        PBTransitionActionMapper *mapper = [PBTransitionActionMapper mapperWithDictionary:actionInfo];
        mapper.name = action;
        if (headerMapper == nil) {
            headerMapper = mapper;
        } else {
            previousMapper.nextMapper = mapper;
        }
        previousMapper = mapper;
    }
    transition->_headerMapper = headerMapper;
    return transition;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [_context.containerView addSubview:_context.toView];
    _context.toView.alpha = 0.f;
    [self animateWithActionMapper:_headerMapper complection:^{
        _context.toView.alpha = 1.f;
        [_context.baseContext completeTransition:YES];
    }];
}

- (void)animateWithActionMapper:(PBTransitionActionMapper *)actionMapper complection:(void (^)())complection {
    if (actionMapper == nil) {
        complection();
        return;
    }
    
    [actionMapper updateWithData:nil andView:_context];
    
    PBTransitionActionMapper *nextMapper = actionMapper.nextMapper;
    if (nextMapper.parallel) {
        [actionMapper animateWithComplection:nil];
        [self animateWithActionMapper:nextMapper complection:complection];
    } else {
        [actionMapper animateWithComplection:^(BOOL finished) {
            [self animateWithActionMapper:actionMapper.nextMapper complection:complection];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [self initContext:transitionContext];
    
    PBTransitionActionMapper *mapper = _headerMapper;
    NSTimeInterval duration = mapper.actionDuration;
    NSTimeInterval lastDuration = duration;
    NSTimeInterval concactDuration = 0.f;
    while ((mapper = mapper.nextMapper) != nil) {
        [mapper updateWithData:nil andView:_context];
        
        NSTimeInterval currentDuration = mapper.actionDuration;
        
        if (!mapper.parallel) {
            concactDuration += lastDuration;
        }
        duration = MAX(duration, concactDuration + currentDuration);
        
        lastDuration = currentDuration;
    }
    return duration;
}

- (void)initContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (_context != nil) {
        return;
    }
    
    PBTransitionContext *context = [[PBTransitionContext alloc] init];
    context.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    context.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    context.containerView = [transitionContext containerView];
    context.fromView = [context.fromVC view];
    context.toView = [context.toVC view];
    context.baseContext = transitionContext;
    _context = context;
}

@end
