//
//  PBDropdownAction.m
//  Pods
//
//  Created by Galen Lin on 30/03/2017.
//
//

#import "PBDropdownAction.h"
#import "PBDropdownMenu.h"
#import "PBPropertyUtils.h"

@implementation PBDropdownAction
{
    PBDropdownMenu *_menu;
}

@pbaction(@"dropdown")
- (void)run:(PBActionState *)state {
    NSString *plist = self.params[@"plist"];
    if (plist == nil) {
        return;
    }
    
    _menu = [[PBDropdownMenu alloc] init];
    for (NSString *key in self.params) {
        id value = self.params[key];
        [PBPropertyUtils setValue:value forKeyPath:key toObject:_menu failure:nil];
    }
    [_menu showAndPointToView:state.context];
}

@end
