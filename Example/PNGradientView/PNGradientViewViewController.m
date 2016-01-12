//
//  PNGradientViewViewController.m
//  PNGradientView
//
//  Created by Giuseppe Nucifora on 01/12/2016.
//  Copyright (c) 2016 Giuseppe Nucifora. All rights reserved.
//

#import "PNGradientViewViewController.h"
#import "PNGradientView.h"

@interface PNGradientViewViewController ()

@end

@implementation PNGradientViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [(PNGradientView*)self.view setBackgroundLayerWithColors:@[[UIColor greenColor],[UIColor whiteColor],[UIColor redColor]] startPoint:CGPointMake(0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
