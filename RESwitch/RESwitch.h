//
// RESwitch.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum _RESwitchLabel {
    RESwitchLabelOn   = 0,
    RESwitchLabelOff  = 1
} RESwitchLabel;

@interface RESwitch : UIControl {
    UIView *_containerView;
    UIView *_backgroundView;
    UIImageView *_backgroundImageView;
    UIImageView *_overlayImageView;
    UIImageView *_knobView;
    UILabel *_onLabel;
    UILabel *_offLabel;
    
    CGFloat _initialOffset;
    CGSize _knobOffset;    
    CGSize _onLabelOffset;
    CGSize _offLabelOffset;
    
    UIColor *_onLabelTextColor;
    UIColor *_offLabelTextColor;
    UIColor *_onLabelTextShadowColor;
    UIColor *_offLabelTextShadowColor;
    
    BOOL _isOn;
}

@property (strong, nonatomic) UIImage *backgroundImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *overlayImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *knobImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *highlightedKnobImage UI_APPEARANCE_SELECTOR;
@property (assign, readwrite, nonatomic) CGSize knobOffset UI_APPEARANCE_SELECTOR;
@property (assign, readwrite, nonatomic) CGSize textShadowOffset UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, getter=isOn) BOOL on;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)radius UI_APPEARANCE_SELECTOR;
- (void)setTextOffset:(CGSize)offset forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;
- (void)setTextColor:(UIColor *)color forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;
- (void)setTextShadowColor:(UIColor *)color forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;
- (void)setTitle:(NSString *)title forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;

- (void)setOn:(BOOL)on;
- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end
