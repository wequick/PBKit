//
//  UIView+PBAnimation.m
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import "UIView+PBAnimation.h"
#import "PBAnimationMapper.h"
#import "PBAnimationInline.h"

@implementation UIView (PBAnimation)

- (void)setPb_anims:(NSArray *)anims {
    NSArray *prevAnims = [self pb_anims];
    for (NSString *animKey in prevAnims) {
        [self.layer removeAnimationForKey:animKey];
    }
    
    [self setValue:anims forAdditionKey:@"pb_anims"];
    
    for (NSString *animPlist in anims) {
        [self pb_loadAnim:animPlist];
    }
}

- (NSArray *)pb_anims {
    return [self valueForAdditionKey:@"pb_anims"];
}

- (void)pb_loadAnim:(NSString *)animPlist {
    CAAnimation *anim = PBAnimationMake(animPlist, self);
    if (anim != nil) {
        [self.layer addAnimation:anim forKey:animPlist];
    }
}

- (void)pb_reloadAnim:(NSString *)animPlist {
    [self.layer removeAnimationForKey:animPlist];
    [self pb_loadAnim:animPlist];
}

@end
