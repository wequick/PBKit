//
//  UIScrollView+PBScrollAction.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import <UIKit/UIKit.h>

@interface UIScrollView (PBScrollAction)

@property (nonatomic, strong) NSArray *pb_scrollActions;

- (void)pb_triggerScrollActions;

@end
