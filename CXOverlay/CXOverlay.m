//
//  CXOverlay.m
//  CALX
//
//  Created by Daniel Clelland on 29/12/14.
//  Copyright (c) 2014 Daniel Clelland. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <ObjectiveSugar/ObjectiveSugar.h>

#import "CXOverlay.h"

@interface CXOverlay ()

@property (nonatomic) BOOL waiting;

@end

@implementation CXOverlay

- (instancetype)initWithCutout:(CGRect)cutout
{
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        
        _cutout = CGRectNull;
    }
    return self;
}

#pragma mark - Cutout setters

- (void)setCutout:(CGRect)cutout
{
    self.waiting = NO;
    if (CGRectEqualToRect(_cutout, cutout)) return;
    _cutout = cutout;
    [self setNeedsDisplay];
}

- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration
{
    [self setCutout:cutout withDuration:duration andDelay:0.0];
}

- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay
{
    [self setCutout:cutout withDuration:duration andDelay:delay andCompletion:nil];
}

- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay andCompletion:(void (^)(BOOL finished))completion
{
    self.waiting = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.waiting) {
            [self setCutout:cutout];
            [UIView transitionWithView:self duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self.layer displayIfNeeded];
            } completion:completion];
        }
    });
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect: bounds: %@ cutout: %@", NSStringFromCGRect(self.bounds), NSStringFromCGRect(self.cutout));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.cutout);
}

@end

@implementation UIView (Overlay)

- (CXOverlay *)overlay
{
    return [self.subviews find:^BOOL(UIView *subview) {
        return [subview isKindOfClass:[CXOverlay class]];
    }];
}

- (void)setOverlay:(CXOverlay *)overlay
{
    [[self.subviews select:^BOOL(UIView *subview) {
        return [subview isKindOfClass:[CXOverlay class]];
    }] each:^(CXOverlay *overlay) {
        [overlay removeFromSuperview];
    }];
    
    [self insertSubview:overlay atIndex:0];
    
    [overlay mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
