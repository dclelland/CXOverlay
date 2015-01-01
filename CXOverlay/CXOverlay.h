//
//  CXOverlay.h
//  CALX
//
//  Created by Daniel Clelland on 29/12/14.
//  Copyright (c) 2014 Daniel Clelland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXOverlay : UIView

@property (nonatomic) CGRect cutout;

- (instancetype)initWithCutout:(CGRect)cutout;

- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration;
- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay;
- (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay andCompletion:(void (^)(BOOL finished))completion;

@end

@interface UIView (CXOverlay)

@property (readwrite) CXOverlay *overlay;

@end