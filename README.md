CXOverlay
=========

### Basic UIView overlay (for tutorials etc.). Inserts itself under all other subviews and uses `drawRect:` to cover the canvas with a colour and then cut out a CGRect.

✓ UIView category convenience methods

    self.view.overlay = [[CXOverlay alloc] initWithColor:[UIColor colorWithWhite:0.0f alpha:0.5f]];
    self.view.overlay.cutout = CGRectMake(24.0f, 24.0f, 44.0f, 44.0f);
    self.view.overlay = nil;

✓ Supports animation with a crossfade effect.

    [self.view.overlay setCutout:CGRectMake(24.0f, 48.0f, 44.0f, 44.0f) withDuration:1.0];

### Full API:

    CXOverlay

    - (instancetype)initWithColor:(UIColor *)color;
    - (instancetype)initWithColor:(UIColor *)color andCutout:(CGRect)cutout;

    - (void)setCutout:(CGRect)cutout;
    - (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration;
    - (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay;
    - (void)setCutout:(CGRect)cutout withDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay andCompletion:(void (^)(BOOL finished))completion;

    UIView (CXOverlay)

    - (void)setOverlay:(CXOverlay *)overlay;
    - (CXOverlay *)overlay;
    