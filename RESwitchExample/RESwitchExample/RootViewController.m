//
//  RootViewController.m
//  RESwitchExample
//
//  Created by Roman Efimov on 2/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "RESwitch.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RESwitch *switchView = [[RESwitch alloc] initWithFrame:CGRectMake(40, 220, 76, 28)];
    switchView.on = NO;
    [switchView setBackgroundImage:[UIImage imageNamed:@"Switch_Background"]];
    [switchView setKnobImage:[UIImage imageNamed:@"Switch_Knob"]];
    [switchView setOverlayImage:nil];
    [switchView setHighlightedKnobImage:nil];
    [switchView setCornerRadius:0];
    [switchView setKnobOffset:CGSizeMake(0, 0)];
    [switchView setTextShadowOffset:CGSizeMake(0, 0)];
    [switchView setFont:[UIFont boldSystemFontOfSize:14]];
    [switchView setTextOffset:CGSizeMake(0, 2) forLabel:RESwitchLabelOn];
    [switchView setTextOffset:CGSizeMake(3, 2) forLabel:RESwitchLabelOff];
    [switchView setTextColor:[UIColor blackColor] forLabel:RESwitchLabelOn];
    [switchView setTextColor:[UIColor colorWithRed:143/255.0 green:19/255.0 blue:24/255.0 alpha:1] forLabel:RESwitchLabelOff];
    switchView.layer.cornerRadius = 4;
    switchView.layer.borderColor = [UIColor colorWithRed:224/255.0 green:36/255.0 blue:24/255.0 alpha:1].CGColor;
    switchView.layer.borderWidth = 2;
    switchView.layer.masksToBounds = YES;
    [switchView addTarget:self action:@selector(switchViewChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchView];
    
    RESwitch *defaultSwitch = [[RESwitch alloc] initWithFrame:CGRectMake(200, 220, 76, 28)];
    [self.view addSubview:defaultSwitch];
}

- (void)switchViewChanged:(RESwitch *)switchView
{
    NSLog(@"Value: %i", switchView.on);
}

@end
