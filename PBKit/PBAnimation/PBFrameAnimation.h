//
//  PBFrameAnimation.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import <Foundation/Foundation.h>

@interface PBFrameAnimation : NSObject

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(CGFloat progress))animations;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(CGFloat progress))animations completion:(void (^)(BOOL finished))completion;

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(CGFloat progress))animations completion:(void (^)(BOOL finished))completion;

@end
