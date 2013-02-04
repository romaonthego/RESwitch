//
//  RESwitch.m
//  SwitchTest
//
//  Created by Roman Efimov on 2/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RESwitch.h"

//#define kKnobOffset 4

@implementation RESwitch

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage overlayImage:(UIImage *)overlayImage knobImage:(UIImage *)knobImage highlightedKnobImage:(UIImage *)highlightedKnobImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _knobXOffset = 0;
        _knobYOffset = 0;
        
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.clipsToBounds = YES;
        [self addSubview:_containerView];
        
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 2, frame.size.height)];
        _backgroundView.userInteractionEnabled = YES;
        [_containerView addSubview:_backgroundView];
        
       // UIImage *backgroundImage = backgroundImage;// [UIImage imageNamed:@"round-switch-track"];
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
        //_backgroundImageView.image = [UIImage imageNamed:@"Switch_Background"];
        _backgroundImageView.image = backgroundImage;
        [_backgroundView addSubview:_backgroundImageView];
        
        _overlayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _overlayImageView.image = overlayImage;// [UIImage imageNamed:@"round-switch-overlay"];
        [self addSubview:_overlayImageView];
        
      // UIImage *knobImage = [UIImage imageNamed:@"round-switch-thumb"];
        // [UIImage imageNamed:@"Switch_Knob"];
        _knobView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, knobImage.size.width, knobImage.size.height)];
        _knobView.image = knobImage;
        [self addSubview:_knobView];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidChange:)];
        [_backgroundView addGestureRecognizer:panGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerDidChange:)];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)radius
{
    _containerView.layer.cornerRadius = radius;
    _containerView.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius
{
    return _containerView.layer.cornerRadius;
}

- (void)setKnobOffsetX:(CGFloat)x y:(CGFloat)y
{
    _knobXOffset = x;
    _knobYOffset = y;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = _backgroundView.frame;
    CGRect knobFrame = _knobView.frame;
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobXOffset;
    knobFrame.origin.y = _knobYOffset;
    _knobView.frame = knobFrame;
}

#pragma mark -
#pragma mark Gesture recognizers

- (void)panGestureRecognizerDidChange:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:_backgroundView];
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		_initialOffset = _backgroundView.frame.origin.x;
	}
	
	float x = translation.x;
	x = translation.x + _initialOffset;
    
    CGRect frame = _backgroundView.frame;
    frame.origin.x = x;
    if (frame.origin.x > 0) {
        frame.origin.x = 0;
    }
    if (frame.origin.x < -self.frame.size.width + _knobView.frame.size.width - _knobXOffset*2)
        frame.origin.x = -self.frame.size.width + _knobView.frame.size.width - _knobXOffset*2;
    _backgroundView.frame = frame;
    
    CGRect knobFrame = _knobView.frame;
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobXOffset;
    _knobView.frame = knobFrame;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (frame.origin.x > -self.frame.size.width / 2) {
            frame.origin.x = 0;
        } else {
            frame.origin.x = -self.frame.size.width + _knobView.frame.size.width - _knobXOffset*2;
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            _backgroundView.frame = frame;
            
            CGRect knobFrame = _knobView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobXOffset;
            _knobView.frame = knobFrame;
        }];
    }
}

- (void)tapGestureRecognizerDidChange:(UIPanGestureRecognizer *)recognizer
{
    /* if (recognizer.state == UIGestureRecognizerStateEnded) {
     CGRect frame = _backgroundView.frame;
     if (frame.origin.x == 0) {
     frame.origin.x = -self.frame.size.width;
     } else {
     frame.origin.x = 0;
     }
     [UIView animateWithDuration:0.15 animations:^{
     _backgroundView.frame = frame;
     }];
     }*/
}

@end
