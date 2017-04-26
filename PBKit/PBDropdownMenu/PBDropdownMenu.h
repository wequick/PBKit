//
//  PBDropdownMenu.h
//  Pods
//
//  Created by Galen Lin on 16/9/12.
//
//

#import <UIKit/UIKit.h>
#import <Pbind/Pbind.h>

/**
 A PBDropdownMenu displays a vertical menu list. It's ususlly used to pop up from the UIBarButtonItem in UINavigationBar.
 
 @discussion Default style:
 
 * backgroundColor: [UIColor whiteColor]
 * separatorColor: [UIColor colorWithWhite:0 alpha:.1]
 */
@interface PBDropdownMenu : PBTableView

/**
 The menu width. Default is 146px.
 */
@property (nonatomic, assign) CGFloat menuWidth;

/**
 The color of cover layer. Default is [UIColor colorWithWhite:0 alpha:.1]
 */
@property (nonatomic, strong) UIColor *coverColor;

/**
 The offset of pointer.
 */
@property (nonatomic, assign) CGSize pointOffset;

/**
 Displays the menu and point to a UIBarButtonItem.
 */
- (void)showAndPointToBarButtonItem:(UIBarButtonItem *)barButtonItem;

/**
 Displays the menu and point to a UIView.
 */
- (void)showAndPointToView:(UIView *)view;

@end
