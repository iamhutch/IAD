//
//  LocalViewController.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/25/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LocalViewController.h"

@interface LocalViewController ()

@end

@implementation LocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button != nil)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
