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
	
    RESwitch *switchView = [[RESwitch alloc] initWithFrame:CGRectMake(30, 100, 76, 28)
                                            backgroundImage:[UIImage imageNamed:@"Switch_Background"]
                                               overlayImage:nil
                                                  knobImage:[UIImage imageNamed:@"Switch_Knob"]
                                       highlightedKnobImage:[UIImage imageNamed:@"Switch_Knob"]];
   // switchView2.cornerRadius = 14;
   // [switchView2 setKnobOffsetX:4 y:-3];
    [self.view addSubview:switchView];
    
    
    
    RESwitch *switchView2 = [[RESwitch alloc] initWithFrame:CGRectMake(30, 100, 76, 28)
                                            backgroundImage:[UIImage imageNamed:@"round-switch-track"]
                                               overlayImage:[UIImage imageNamed:@"round-switch-overlay"]
                                                  knobImage:[UIImage imageNamed:@"round-switch-thumb"]
                                       highlightedKnobImage:[UIImage imageNamed:@"round-switch-thumb"]];
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
