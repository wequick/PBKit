//
//  PBImageView.m
//  Pods
//
//  Created by Galen Lin on 27/03/2017.
//
//

#import "PBImageView.h"

@implementation PBImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.rounded) {
        self.layer.cornerRadius = self.bounds.size.width / 2;
    }
}

- (void)setRounded:(BOOL)rounded {
    if (_rounded == rounded) {
        return;
    }
    
    if (rounded) {
        self.clipsToBounds = YES;
        [self setNeedsLayout];
    } else {
        self.clipsToBounds = NO;
        self.layer.cornerRadius = 0;
    }
    _rounded = rounded;
}

@end
