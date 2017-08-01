//
//  PBScrollAction.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PBScrollActionMapper.h"

@protocol PBScrollAction <NSObject>

- (BOOL)canRunActionWithScrollView:(UIScrollView *)scrollView;

- (void)actionWithScrollView:(UIScrollView *)scrollView;

@end

@interface PBScrollAction : NSObject <PBScrollAction>

+ (instancetype)actionWithMapper:(PBScrollActionMapper *)mapper;

@property (nonatomic, strong) id target;

@property (nonatomic, strong) NSString *keyPath;

@end
