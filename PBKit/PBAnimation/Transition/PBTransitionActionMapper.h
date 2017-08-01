//
//  PBTransitionActionMapper.h
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import <Pbind/Pbind.h>

@interface PBTransitionActionMapper : PBMapper

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, assign) CGFloat delay;

@property (nonatomic, assign) UIViewAnimationOptions options;

@property (nonatomic, strong) UIView *target;

@property (nonatomic, strong) NSString *keyPath;

@property (nonatomic, strong) id fromValue;

@property (nonatomic, strong) id toValue;

@property (nonatomic, strong) id byValue;

/**
 Animates the action together with last action.
 
 @discussion Default is NO, which will animates the action after last action complected..
 */
@property (nonatomic, assign) BOOL parallel;

#pragma mark - Calculating
///=============================================================================
/// @name Calculating
///=============================================================================

/**
 The whole duration for the action.
 
 @discussion If `target` and `key` was not specified, return 0. Otherwise, returns `duration` plus `delay`.
 */
@property (nonatomic, assign, readonly) CGFloat actionDuration;

- (void)animateWithComplection:(void (^)(BOOL finished))complection;

#pragma mark - Ordering
///=============================================================================
/// @name Ordering
///=============================================================================

@property (nonatomic, strong) PBTransitionActionMapper *nextMapper;

#pragma mark - Caching
///=============================================================================
/// @name Caching
///=============================================================================

@property (nonatomic, strong) NSString *name;

@end
