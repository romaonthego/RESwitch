//
// RESwitch.m
// RESwitch
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RESwitch.h"

@implementation RESwitch

+ (void)initialize
{
    [super initialize];
    
    [[RESwitch appearance] setBackgroundImage:[UIImage imageNamed:@"RESwitch.bundle/Background"]];
    [[RESwitch appearance] setOverlayImage:[UIImage imageNamed:@"RESwitch.bundle/Overlay"]];
    [[RESwitch appearance] setKnobImage:[UIImage imageNamed:@"RESwitch.bundle/Knob"]];
    [[RESwitch appearance] setHighlightedKnobImage:[UIImage imageNamed:@"RESwitch.bundle/Knob_Highlighted"]];
    [[RESwitch appearance] setKnobOffset:CGSizeMake(4, -3)];
    [[RESwitch appearance] setCornerRadius:14];
    [[RESwitch appearance] setFont:[UIFont boldSystemFontOfSize:17]];
    [[RESwitch appearance] setTextOffset:CGSizeMake(0, 0) forLabel:RESwitchLabelOn];
    [[RESwitch appearance] setTextOffset:CGSizeMake(0, 0) forLabel:RESwitchLabelOff];
    [[RESwitch appearance] setTextShadowOffset:CGSizeMake(0, -1)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self commonInitWithFrame:frame];
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    [self commonInitWithFrame:self.frame];
    return self;
}

- (void)commonInitWithFrame:(CGRect)frame
{
    self.on = YES;
    _knobOffset = CGSizeMake(0, 0);
    _textShadowOffset = CGSizeMake(0, -1);
    _font = [UIFont boldSystemFontOfSize:17];
    _onLabelOffset = CGSizeMake(0, 0);
    _offLabelOffset = CGSizeMake(0, 0);
    _onLabelTextColor = [UIColor whiteColor];
    _offLabelTextColor = [UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:1];
    _onLabelTextShadowColor = [UIColor colorWithRed:0 green:102/255.0 blue:186/255.0 alpha:1];
    _offLabelTextShadowColor = [UIColor clearColor];
    
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.clipsToBounds = YES;
    [self addSubview:_containerView];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 2, frame.size.height)];
    _backgroundView.userInteractionEnabled = YES;
    [_containerView addSubview:_backgroundView];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectNull];
    [_backgroundView addSubview:_backgroundImageView];
    
    _overlayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_overlayImageView];
    
    _knobView = [[UIImageView alloc] initWithFrame:CGRectNull];
    [self addSubview:_knobView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidChange:)];
    [_backgroundView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerDidChange:)];
    [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    _onLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 20, 10)];
    _onLabel.text = NSLocalizedString(@"ON", @"ON");
    _onLabel.backgroundColor = [UIColor clearColor];
    [_backgroundView addSubview:_onLabel];
    
    _offLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 20, 10)];
    _offLabel.text = NSLocalizedString(@"OFF", @"OFF");
    _offLabel.backgroundColor = [UIColor clearColor];
    [_backgroundView addSubview:_offLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _containerView.frame = self.bounds;
    _backgroundView.frame = CGRectMake(0, 0, self.frame.size.width * 2, self.frame.size.height);
    
    CGRect frame = _backgroundView.frame;
    frame.origin.x = _isOn ? 0 : self.offPosition;
    _backgroundView.frame = frame;

    _backgroundImageView.image = _backgroundImage;
    _overlayImageView.image = _overlayImage;
    _knobView.image = _knobImage;
    
    _backgroundImageView.frame = CGRectMake(0, 0, _backgroundImage.size.width, _backgroundImage.size.height);
    frame = _backgroundView.frame;
    CGRect knobFrame = CGRectMake(0, 0, _knobImage.size.width, _knobImage.size.height);
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobOffset.width;
    knobFrame.origin.y = _knobOffset.height;
    _knobView.frame = knobFrame;
    
    
    [_onLabel sizeToFit];
    [_offLabel sizeToFit];

    CGRect onFrame = _onLabel.frame;
    onFrame.origin.x = 15 + _onLabelOffset.width;
    onFrame.origin.y = 3 + _onLabelOffset.height;
    _onLabel.frame = onFrame;
    
    CGRect offFrame = _offLabel.frame;
    offFrame.origin.x = _backgroundImageView.frame.size.width - offFrame.size.width - 10 + _offLabelOffset.width;
    offFrame.origin.y = 3 + _offLabelOffset.height;
    _offLabel.frame = offFrame;
    
    _onLabel.shadowOffset = _textShadowOffset;
    _onLabel.font = _font;
    _onLabel.textColor = _onLabelTextColor;
    _onLabel.shadowColor = _onLabelTextShadowColor;
    
    _offLabel.shadowOffset = _textShadowOffset;
    _offLabel.font = _font;
    _offLabel.textColor = _offLabelTextColor;
    _offLabel.shadowColor = _offLabelTextShadowColor;
    
    [_onLabel sizeToFit];
    [_offLabel sizeToFit];
}

- (CGFloat)offPosition
{
    return -self.frame.size.width + _knobImage.size.width - _knobOffset.width*2;
}

- (BOOL)isOn
{
    return _backgroundView.frame.origin.x == 0;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated
{
    if (animated) {
        _isOn = on;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _backgroundView.frame;
            frame.origin.x = on ? 0 : self.offPosition;
            _backgroundView.frame = frame;
            
            CGRect knobFrame = _knobView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobOffset.width;
            _knobView.frame = knobFrame;
        }];
    } else {
        [self setOn:on];
    }
}

- (void)setOn:(BOOL)on
{
    _isOn = on;
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark Apperance

- (void)setCornerRadius:(CGFloat)radius
{
    _containerView.layer.cornerRadius = radius;
    _containerView.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius
{
    return _containerView.layer.cornerRadius;
}

- (void)setKnobOffset:(CGSize)knobOffset
{
    _knobOffset = knobOffset;
    [self setNeedsLayout];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [self setNeedsLayout];
}

- (void)setOverlayImage:(UIImage *)overlayImage
{
    _overlayImage = overlayImage;
    [self setNeedsLayout];
}

- (void)setKnobImage:(UIImage *)knobImage
{
    _knobImage = knobImage;
    [self setNeedsLayout];
}

- (void)setHighlightedKnobImage:(UIImage *)highlightedKnobImage
{
    _highlightedKnobImage = highlightedKnobImage;
    [self setNeedsLayout];
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset
{
    _textShadowOffset = textShadowOffset;
    [self setNeedsLayout];
}

- (void)setTextOffset:(CGSize)offset forLabel:(RESwitchLabel)label
{
    if (label == RESwitchLabelOn)
        _onLabelOffset = offset;
    
    if (label == RESwitchLabelOff)
        _offLabelOffset = offset;
    
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)color forLabel:(RESwitchLabel)label
{
    if (label == RESwitchLabelOn)
        _onLabelTextColor = color;
    
    if (label == RESwitchLabelOff)
        _offLabelTextColor = color;
    
    [self setNeedsLayout];
}

- (void)setTextShadowColor:(UIColor *)color forLabel:(RESwitchLabel)label
{
    if (label == RESwitchLabelOn)
        _onLabelTextShadowColor = color;
    
    if (label == RESwitchLabelOff)
        _offLabelTextShadowColor = color;
    
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forLabel:(RESwitchLabel)label
{
    if (label == RESwitchLabelOn)
        _onLabel.text = title;
    
    if (label == RESwitchLabelOff)
        _offLabel.text = title;
    
    [self setNeedsLayout];
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
    if (frame.origin.x < self.offPosition)
        frame.origin.x = self.offPosition;
    _backgroundView.frame = frame;
    
    CGRect knobFrame = _knobView.frame;
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobOffset.width;
    _knobView.frame = knobFrame;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (_highlightedKnobImage)
            _knobView.image = _highlightedKnobImage;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _knobView.image = _knobImage;
        
        if (frame.origin.x > -self.frame.size.width / 2) {
            frame.origin.x = 0;
        } else {
            frame.origin.x = self.offPosition;
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            _backgroundView.frame = frame;
            
            CGRect knobFrame = _knobView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobOffset.width;
            _knobView.frame = knobFrame;
        }];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)tapGestureRecognizerDidChange:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _knobView.image = _knobImage;

        CGRect frame = _backgroundView.frame;

        if (frame.origin.x == 0) {
            frame.origin.x = self.offPosition;
        } else {
            frame.origin.x = 0;
        }
        [UIView animateWithDuration:0.15 animations:^{
            _backgroundView.frame = frame;

            CGRect knobFrame = _knobView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width + _knobOffset.width;
            _knobView.frame = knobFrame;
        }];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_highlightedKnobImage)
        _knobView.image = _highlightedKnobImage;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _knobView.image = _knobImage;
}

@end
