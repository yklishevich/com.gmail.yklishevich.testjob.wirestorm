#import "KMKDimmedViewWithActivityIndicator.h"


@interface KMKDimmedViewWithActivityIndicator ()

@property (weak, nonatomic) UIView *tintingView;

@end

@implementation KMKDimmedViewWithActivityIndicator {
    UIActivityIndicatorView *_activityIndicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)adjustToBoundsOfSuperView
{
    self.frame = self.superview.bounds;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)showActivityIndicator
{
    [self addTintedBackground];
    [self addIndicatorItself];
    [_activityIndicatorView startAnimating];
}

- (void)hideActivityIndicator
{
    [self removeTintedBackround];
    [_activityIndicatorView stopAnimating];
}

- (void)addTintedBackground
{
    UIView *tintingView = [[UIView alloc] initWithFrame:self.bounds];
    tintingView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:tintingView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = tintingView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite:0.5 alpha:0.4]CGColor],
                       (id)[[UIColor colorWithWhite:0.3 alpha:0.5] CGColor],
                       (id)[[UIColor colorWithWhite:0.3 alpha:0.5] CGColor],
                       (id)[[UIColor colorWithWhite:0.5 alpha:0.4] CGColor], nil];
    [tintingView.layer addSublayer:gradient];
    
    self.tintingView = tintingView;
}

- (void)removeTintedBackround
{
    [self.tintingView removeFromSuperview];
}

- (void)addIndicatorItself
{
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    _activityIndicatorView.center = [self.tintingView convertPoint:self.tintingView.center fromView:self];
    _activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
                                                    UIViewAutoresizingFlexibleLeftMargin |
                                                    UIViewAutoresizingFlexibleTopMargin |
                                                    UIViewAutoresizingFlexibleBottomMargin;

    [self.tintingView addSubview:_activityIndicatorView];
}


@end
