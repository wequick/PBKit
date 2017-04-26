//
//  UIView+PBAnimation.h
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import <UIKit/UIKit.h>

@interface UIView (PBAnimation)

@property (nonatomic, strong) NSArray<NSString *> *pb_anims;

- (void)pb_loadAnim:(NSString *)animPlist;
- (void)pb_reloadAnim:(NSString *)animPlist;

@end
