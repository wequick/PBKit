//
//  UIViewController+PBTransition.h
//  PBScrollMonitor
//
//  Created by galen on 17/7/22.
//  Copyright © 2017年 galen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PBTransition)

@property (nonatomic, strong) NSArray *pb_enterActions;

@property (nonatomic, strong) NSArray *pb_leaveActions;

@end
