//
//  PBAnimationMapper.m
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import "PBAnimationMapper.h"
#import "Pbind+API.h"
#import "UIView+PBAnimation.h"

@implementation PBAnimationMapper

+ (void)load {
    [PBValueParser registerEnums:@{@"repeatForever": @(HUGE_VALF)}];
    [Pbind registerPlistReloader:^(UIView *rootView, UIView *view, NSString *changedPlist, BOOL *stop) {
        NSArray *animPlistNames = view.pb_anims;
        if (animPlistNames != nil && [animPlistNames containsObject:changedPlist]) {
            [view pb_reloadAnim:changedPlist];
        }
    }];
}

- (Class)animationClass {
    NSString *clazz = self.clazz;
    if (clazz == nil) {
        if (self.type != nil && self.type.length >= 2) {
            clazz = [NSString stringWithFormat:@"CA%c%@Animation", toupper([self.type characterAtIndex:0]), [self.type substringFromIndex:1]];
        } else {
            return [CABasicAnimation class];
        }
    }
    
    return NSClassFromString(clazz);
}

@end
