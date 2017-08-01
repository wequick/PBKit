//
//  PBScrollAction.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollAction.h"
#import <Pbind/Pbind.h>

@implementation PBScrollAction
{
    PBScrollActionMapper *_mapper;
}

+ (instancetype)actionWithMapper:(PBScrollActionMapper *)mapper {
    PBScrollAction *action = [[mapper.actionClass alloc] init];
    action->_mapper = mapper;
    return action;
}

- (void)_internalActionWithScrollView:(UIScrollView *)scrollView {
    if (_mapper != nil) {
        [_mapper setPropertiesToObject:self transform:nil];
        self.target = _mapper.target;
        [_mapper mapPropertiesToObject:self withData:scrollView.rootData context:scrollView];
    }
    
    if ([self respondsToSelector:@selector(canRunActionWithScrollView:)]) {
        if (![self canRunActionWithScrollView:scrollView]) {
            return;
        }
    }
    
    if ([self respondsToSelector:@selector(actionWithScrollView:)]) {
        [self actionWithScrollView:scrollView];
    }
}

@end
