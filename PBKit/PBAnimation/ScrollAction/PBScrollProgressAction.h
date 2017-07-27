//
//  PBScrollProgressAction.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollAction.h"

@interface PBScrollProgressAction : PBScrollAction

/* The objects defining the property values being interpolated between.
 * The supported modes of animation are:
 *
 * - both `fromValue' and `toValue' non-nil. Interpolates between
 * `fromValue' and `toValue' while the scrollView scroll from
 * `fromOffset' to `toOffset'.
 *
 * - `toValue' non-nil. Interpolates between the `target' current value
 * of the property and `toValue' while the scrollView scroll from
 * `fromOffset' to `toOffset'. */

@property (nonatomic, assign) CGFloat fromOffset;

@property (nonatomic, assign) CGFloat toOffset;

@property (nonatomic, strong) id fromValue;

@property (nonatomic, strong) id toValue;

@end
