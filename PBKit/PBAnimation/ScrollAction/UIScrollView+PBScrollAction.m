//
//  UIScrollView+PBScrollAction.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "UIScrollView+PBScrollAction.h"
#import "PBScrollActionMapper.h"
#import "PBScrollAction.h"
#import <Pbind/Pbind.h>

@interface PBScrollAction (Private)

- (void)_internalActionWithScrollView:(UIScrollView *)scrollView;

@end

@implementation UIScrollView (PBScrollAction)

static NSString *const kPBScrollActionsKey = @"pb_scrollActions";
static NSString *const kPBScrollActionMappersKey = @"pb_scrollActionMappers";

- (void)setPb_scrollActions:(NSArray *)value {
    [self setValue:value forAdditionKey:kPBScrollActionsKey];
}

- (NSArray *)pb_scrollActions {
    return [self valueForAdditionKey:kPBScrollActionsKey];
}

- (void)pb_triggerScrollActions {
    NSArray *actions = self.pb_scrollActions;
    if (actions.count == 0) {
        return;
    }
    
    NSMutableArray *facadeActions = [NSMutableArray arrayWithCapacity:actions.count];
    
    for (id action in actions) {
        PBScrollAction *scrollAction = nil;
        if ([action isKindOfClass:[PBScrollAction class]]) {
            scrollAction = action;
        } else if ([action isKindOfClass:[NSString class]]) {
            NSDictionary *info = PBPlist(action);
            PBScrollActionMapper *mapper = [PBScrollActionMapper mapperWithDictionary:info];
            [mapper updateWithData:nil andView:self];
            scrollAction = [PBScrollAction actionWithMapper:mapper];
        } else if ([action isKindOfClass:[NSDictionary class]]) {
            PBScrollActionMapper *mapper = [PBScrollActionMapper mapperWithDictionary:action];
            [mapper updateWithData:nil andView:self];
            scrollAction = [PBScrollAction actionWithMapper:mapper];
        }
        
        if (scrollAction == nil) {
            continue;
        }
        [scrollAction _internalActionWithScrollView:self];
        [facadeActions addObject:scrollAction];
    }
    
    self.pb_scrollActions = facadeActions;
}

@end
