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
        [_mapper initPropertiesForTarget:self transform:nil];
        self.target = _mapper.target;
        [_mapper mapPropertiesToTarget:self withData:scrollView.rootData owner:scrollView context:scrollView];
    }
    
    if (![self canRunActionWithScrollView:scrollView]) {
        return;
    }
    
    [self actionWithScrollView:scrollView];
}

- (BOOL)canRunActionWithScrollView:(UIScrollView *)scrollView {
    return YES;
}

- (void)actionWithScrollView:(UIScrollView *)scrollView {
    // Stub
}

@end
