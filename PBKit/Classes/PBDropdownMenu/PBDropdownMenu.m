//
//  PBDropdownMenu.m
//  Pods
//
//  Created by Galen Lin on 16/9/12.
//
//

#import "PBDropdownMenu.h"

@class _PBDropdownCover;
@class _PBDropdownIndicator;

static const CGFloat        kIndicatorWidth = 12.f;
static const CGFloat        kIndicatorHeight = 8.f; // √3 / 2
static const CGFloat        kMarginTop = 0;
static const CGFloat        kMarginRight = 8.f;

static _PBDropdownIndicator *kIndicator;
static _PBDropdownCover     *kCover;
static PBDropdownMenu       *kPopingMenu;
static UIWindow             *kPopingWindow;
static CGRect                kTargetRect;

@interface PBDropdownMenu (Private)

- (void)hideWithAnimated:(BOOL)animated;

@end

#pragma mark - Indicator

@interface _PBDropdownIndicator : UIView

@property (nonatomic, assign) CGRect indicatorFrame;
@property (nonatomic, strong) UIColor *indicatorColor;

@end

@implementation _PBDropdownIndicator

@synthesize indicatorFrame;

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(indicatorFrame), CGRectGetMaxY(rect));  // left bottom
    CGContextAddLineToPoint(ctx, CGRectGetMidX(indicatorFrame), CGRectGetMinY(rect));  // mid top
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(indicatorFrame), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    
    [self.indicatorColor setFill];
    CGContextFillPath(ctx);
}

@end

#pragma mark - Cover

@interface _PBDropdownCover : UIView

@end

@implementation _PBDropdownCover

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    [kPopingMenu hideWithAnimated:YES];
}

@end

#pragma mark - PBTableView - Private

@interface PBTableView (Private)

- (void)config;

@end

#pragma mark - PBDropdownMenu

@implementation PBDropdownMenu

- (void)config {
    [super config];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 8.f;
    self.scrollEnabled = NO;
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.menuWidth = 146.0f;
    self.coverColor = [UIColor colorWithWhite:0 alpha:.1];
    self.separatorColor = [UIColor colorWithWhite:0 alpha:.1];
}

- (void)showAndPointToBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIView *view = [barButtonItem valueForKey:@"_view"];
    [self showAndPointToView:view];
}

- (void)showAndPointToView:(UIView *)view {
    UIWindow *window = view.window;
    kTargetRect = [view convertRect:view.bounds toView:window];
    kPopingWindow = window;
    kPopingMenu = self;
    if (kIndicator == nil) {
        kIndicator = [[_PBDropdownIndicator alloc] init];
    }
    if (kCover == nil) {
        kCover = [[_PBDropdownCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    CGFloat x = CGRectGetMidX(kTargetRect);
    CGFloat y = CGRectGetMaxY(kTargetRect) + kMarginTop;
    CGRect frame = [UIScreen mainScreen].bounds;
    
    frame.origin.y = y;
    frame.size.height = kIndicatorHeight;
    [kIndicator setFrame:frame];
    [kIndicator setBackgroundColor:[UIColor clearColor]];
    CGRect indicatorFrame = CGRectMake(x - (kIndicatorWidth / 2), y, kIndicatorWidth, kIndicatorHeight);
    [kIndicator setIndicatorFrame:indicatorFrame];
    
    [kPopingMenu setFrame:CGRectMake(x, y, 0, 0)];
    
    [kPopingWindow addSubview:kCover];
    [kPopingWindow addSubview:kIndicator];
    [kPopingWindow addSubview:kPopingMenu];
    
    if (self.rows == nil && self.row == nil) {
        // Waiting for reloadData
        return;
    }
    [self showWithAnimated];
}

- (void)showWithAnimated {
    [kIndicator setIndicatorColor:kPopingMenu.backgroundColor];
    [kIndicator setNeedsDisplay];
    [kCover setBackgroundColor:kPopingMenu.coverColor];
    [kCover setAlpha:0];
    [kIndicator setAlpha:0];
    [kPopingMenu setAlpha:0];
    
    [UIView animateWithDuration:.3 animations:^{
        CGFloat y = CGRectGetMaxY(kTargetRect) + kMarginTop;
        CGSize size = kPopingMenu.contentSize;
        size.width = kPopingMenu.menuWidth;
        [kPopingMenu setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - size.width - kMarginRight, y + kIndicatorHeight, size.width, size.height)];
        [kCover setAlpha:1];
        [kIndicator setAlpha:1];
        [kPopingMenu setAlpha:1];
    }];
}

- (void)hideWithAnimated:(BOOL)animated {
    [self hideWithAnimated:animated completion:nil];
}

- (void)hideWithAnimated:(BOOL)animated completion:(dispatch_block_t)completion {
    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:NO];
    
    void (^onHide)(BOOL finished) = ^(BOOL finished) {
        if (completion != nil) {
            completion();
        }
        
        [kIndicator removeFromSuperview];
        [kCover removeFromSuperview];
        [self removeFromSuperview];
        
        kIndicator = nil;
        kCover = nil;
        kPopingMenu = nil;
        kPopingWindow = nil;
    };
    
    if (animated) {
        CGFloat x = CGRectGetMidX(kTargetRect);
        CGFloat y = CGRectGetMaxY(kTargetRect) + kMarginTop;
        [UIView animateWithDuration:.2 animations:^{
            [kPopingMenu setFrame:CGRectMake(x, y, 0, 0)];
            [kCover setAlpha:0];
            [kIndicator setAlpha:0];
            [kPopingMenu setAlpha:0];
        } completion:onHide];
    } else {
        onHide(YES);
    }
}

- (void)reloadData {
    [super reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showWithAnimated];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideWithAnimated:NO completion:^{
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }];
}

@end
