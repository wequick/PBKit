//
//  PBScrollTriggerAction.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollAction.h"

@interface PBScrollTriggerAction : PBScrollAction

/**
 The Javascript for evaluating the BOOL condition which determines whether we
 should dispatch `testAction`.
 */
@property (nonatomic, strong) NSString *test;

/**
 The action to be dispatched while the `test` condition meets
 
 @discussion This will be parsed as a `PBAction`
 */
@property (nonatomic, strong) NSDictionary *testAction;

@end
