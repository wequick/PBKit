//
//  PBScrollTriggerAction.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollTriggerAction.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Pbind/Pbind.h>

@implementation PBScrollTriggerAction
{
    PBActionMapper *_testActionMapper;
}

- (BOOL)canRunActionWithScrollView:(UIScrollView *)scrollView {
    if (!scrollView.dragging) {
        return NO;
    }
    
    if (self.test == nil || self.testAction == nil) {
        return NO;
    }
    
    JSContext *context = [[JSContext alloc] init];
    context[@"y"] = @(scrollView.contentOffset.y);
    BOOL passed = [[context evaluateScript:self.test] toBool];
    return passed;
}

- (void)actionWithScrollView:(UIScrollView *)scrollView {
    BOOL temp = scrollView.scrollEnabled;
    scrollView.scrollEnabled = NO;
    
    [[PBActionStore defaultStore] dispatchActionWithActionMapper:self.testActionMapper context:scrollView];
    
    scrollView.scrollEnabled = temp;
}

- (PBActionMapper *)testActionMapper {
    if (_testAction == nil) {
        return nil;
    }
    
    if (_testActionMapper == nil) {
        _testActionMapper = [PBActionMapper mapperWithDictionary:_testAction];
    }
    return _testActionMapper;
}

@end
