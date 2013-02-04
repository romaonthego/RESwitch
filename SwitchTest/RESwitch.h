//
//  RESwitch.h
//  SwitchTest
//
//  Created by Roman Efimov on 2/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum _RESwitchLabel {
    RESwitchLabelOn   = 0,
    RESwitchLabelOff  = 1
} RESwitchLabel;

@interface RESwitch : UIView {
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
}

@property (strong, nonatomic) UIImage *backgroundImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *overlayImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *knobImage UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIImage *highlightedKnobImage UI_APPEARANCE_SELECTOR;
@property (assign, readwrite, nonatomic) CGSize knobOffset UI_APPEARANCE_SELECTOR;
@property (assign, readwrite, nonatomic) CGSize textShadowOffset UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)radius UI_APPEARANCE_SELECTOR;
- (void)setTextOffset:(CGSize)offset forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;
- (void)setTextColor:(UIColor *)color forLabel:(RESwitchLabel)label UI_APPEARANCE_SELECTOR;

@end
