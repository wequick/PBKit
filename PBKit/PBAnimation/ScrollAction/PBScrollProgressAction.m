//
//  PBScrollProgressAction.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollProgressAction.h"
#import "PBScrollActionProgressing.h"
#import <Pbind/Pbind.h>

@implementation PBScrollProgressAction

- (BOOL)canRunActionWithScrollView:(UIScrollView *)scrollView {
    return self.target != nil && self.keyPath != nil;
}

- (void)actionWithScrollView:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    id value = [self valueForOffset:offset];
    [self.target pb_setValue:value forKeyPath:self.keyPath];
}

- (id)valueForOffset:(CGFloat)offset {
    if (_fromValue == nil || _toValue == nil) {
        return nil;
    }
    
    if (_fromOffset == _toOffset) {
        return _fromValue;
    }
    
    CGFloat minOffset, maxOffset;
    id minValue, maxValue;
    if (_fromOffset < _toOffset) {
        minOffset = _fromOffset;
        maxOffset = _toOffset;
        minValue = _fromValue;
        maxValue = _toValue;
    } else {
        minOffset = _toOffset;
        maxOffset = _fromOffset;
        minValue = _toValue;
        maxValue = _fromValue;
    }
    
    if (offset <= minOffset) {
        return minValue;
    }
    
    if (offset >= maxOffset) {
        return maxValue;
    }
    
    Class valueClass = [minValue class];
    if (![valueClass conformsToProtocol:@protocol(PBScrollActionProgressing)]) {
        return minValue;
    }
    
    double progress = (offset - _fromOffset) / (_toOffset - _fromOffset);
    return [valueClass valueWithProgress:progress fromValue:_fromValue toValue:_toValue];
}

@end


