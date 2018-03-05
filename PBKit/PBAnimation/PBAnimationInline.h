//
//  PBAnimationInline.h
//  PBKit
//
//  Created by galen on 2018/3/3.
//

#import <UIKit/UIKit.h>
#import "PBAnimationMapper.h"

UIKIT_STATIC_INLINE CAAnimation *PBAnimationFromDictionary(NSDictionary *animConfig, UIView *targetView)
{
    if (animConfig == nil) {
        return nil;
    }
    
    PBAnimationMapper *animMapper = [PBAnimationMapper mapperWithDictionary:animConfig];
    Class animClass = [animMapper animationClass];
    if (animClass == nil) {
        return nil;
    }
    
    CAAnimation *anim = [animClass animation];
    [animMapper initPropertiesForTarget:anim];
    [animMapper mapPropertiesToTarget:anim withData:nil owner:targetView context:targetView];
    return anim;
}

UIKIT_STATIC_INLINE CAAnimation *PBAnimationMake(NSString *plist, UIView *targetView)
{
    NSDictionary *animConfig = PBPlist(plist);
    return PBAnimationFromDictionary(animConfig, targetView);
}
