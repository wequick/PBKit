//
//  PBScrollActionMapper.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import <Pbind/Pbind.h>

@interface PBScrollActionMapper : PBMapper

#pragma mark - Plisting
///=============================================================================
/// @name Plisting
///=============================================================================

/**
 The scroll action type, supports:
 - progress (DEFAULT)
 - evaluate
 - trigger
 which would dispatch the action to `PB[Type]ScrollAction'
 */
@property (nonatomic, strong) NSString *type;

/**
 The action plist used to map properties to `PB[Type]ScrollAction'
 */
@property (nonatomic, strong) NSString *action;

@property (nonatomic, strong) id target;

#pragma mark - Caching
///=============================================================================
/// @name Caching
///=============================================================================

@property (nonatomic, weak) Class actionClass;

@end
