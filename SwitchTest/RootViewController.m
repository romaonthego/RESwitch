//
//  RootViewController.m
//  SwitchTest
//
//  Created by Roman Efimov on 2/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "RESwitch.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[RESwitch appearance] setBackgroundImage:[UIImage imageNamed:@"round-switch-track"]];
    [[RESwitch appearance] setOverlayImage:[UIImage imageNamed:@"round-switch-overlay"]];
    [[RESwitch appearance] setKnobImage:[UIImage imageNamed:@"round-switch-thumb"]];
    [[RESwitch appearance] setHighlightedKnobImage:[UIImage imageNamed:@"round-switch-thumb-highlight"]];
	
    RESwitch *switchView = [[RESwitch alloc] initWithFrame:CGRectMake(30, 100, 76, 28)];
    [switchView setBackgroundImage:[UIImage imageNamed:@"Switch_Background"]];
    [switchView setKnobImage:[UIImage imageNamed:@"Switch_Knob"]];
    [switchView setOverlayImage:nil];
    [switchView setHighlightedKnobImage:nil];
    [self.view addSubview:switchView];
    
    RESwitch *switchView2 = [[RESwitch alloc] initWithFrame:CGRectMake(30, 200, 76, 28)];
    switchView2.cornerRadius = 14;
    [switchView2 setKnobOffsetX:4 y:-3];
    [self.view addSubview:switchView2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
