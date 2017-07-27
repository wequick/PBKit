//
//  PBTransition.h
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBControllerTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)enterTransitionForViewController:(UIViewController *)viewController;

+ (instancetype)leaveTransitionForViewController:(UIViewController *)viewController;

+ (instancetype)transitionWithActions:(NSArray *)actions;

@end
