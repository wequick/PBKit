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

+ (JSContext *)sharedJSContext {
    static JSContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [[JSContext alloc] init];
    });
    return context;
}

- (BOOL)canRunActionWithScrollView:(UIScrollView *)scrollView {
    if (!scrollView.dragging) {
        return NO;
    }
    
    if (self.test == nil || self.testAction == nil) {
        return NO;
    }
    
    JSContext *context = [[self class] sharedJSContext];
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
