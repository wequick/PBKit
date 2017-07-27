//
//  PBScrollActionMapper.m
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollActionMapper.h"
#import "PBScrollProgressAction.h"

@implementation PBScrollActionMapper

- (void)setType:(NSString *)type {
    _type = type;
    if (type == nil || type.length < 2) {
        _actionClass = nil;
        return;
    }
    
    NSString *clazz = [NSString stringWithFormat:@"PBScroll%c%@Action", toupper([type characterAtIndex:0]), [type substringFromIndex:1]];
    _actionClass = NSClassFromString(clazz);
}

- (void)setAction:(NSString *)action {
    _viewProperties = [PBMapperProperties propertiesWithDictionary:PBPlist(action)];
}

- (Class)actionClass {
    if (_actionClass != nil) {
        return _actionClass;
    }
    return [PBScrollProgressAction class];
}

@end
