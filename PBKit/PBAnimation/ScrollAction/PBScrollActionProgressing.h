//
//  PBScrollActionProgressing.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import <Foundation/Foundation.h>

@protocol PBScrollActionProgressing <NSObject>

+ (id)valueWithProgress:(double)progress fromValue:(id)fromValue toValue:(id)toValue;

@end
