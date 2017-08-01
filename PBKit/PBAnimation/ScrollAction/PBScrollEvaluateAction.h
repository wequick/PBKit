//
//  PBScrollEvaluateAction.h
//  Pods
//
//  Created by galen on 17/7/24.
//
//

#import "PBScrollAction.h"

@interface PBScrollEvaluateAction : PBScrollAction

/**
 The Javascript for evaluating the value for the key of the target.
 
 @discussion The built-in variables are:
 
 - offset, scrollView.contentOffset
 - inset, scrollView.contentInsets
 
 */
@property (nonatomic, strong) NSString *value;

@end
