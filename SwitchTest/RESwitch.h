//
//  RESwitch.h
//  SwitchTest
//
//  Created by Roman Efimov on 2/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RESwitch : UIView {
    UIView *_containerView;
    UIView *_backgroundView;
    UIImageView *_backgroundImageView;
    UIImageView *_overlayImageView;
    UIImageView *_knobView;
    CGFloat _initialOffset;
    
    CGFloat _knobXOffset;
    CGFloat _knobYOffset;
    
    UILabel *_onLabel;
    UILabel *_offLabel;
}

@property (strong, nonatomic) UIImage *backgroundImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *overlayImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *knobImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *highlightedKnobImage UI_APPEARANCE_SELECTOR;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)radius;
- (void)setKnobOffsetX:(CGFloat)x y:(CGFloat)y;

@end
