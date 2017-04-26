//
//  PBAnimationMapper.h
//  Pods
//
//  Created by Galen Lin on 26/04/2017.
//
//

#import <Pbind/Pbind.h>

@interface PBAnimationMapper : PBMapper

@property (nonatomic, strong) NSString *type; // basic, keyframe


/**
 The CAAnimation class.
 
 @discussion Default is CABasicAnimation.
 
 If the type was specified, use 'CA[Type]Animation'.
 */
@property (nonatomic, strong) NSString *clazz; // CABasicAnimation

- (Class)animationClass;

@end
