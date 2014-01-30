//
//  SettingsViewController.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/29/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *savedUserName = [userDefaults objectForKey:@"username"];
    userName.text = savedUserName;
    
    BOOL *musicSetting = [userDefaults boolForKey:@"musicSetting"];
    if (musicSetting)
    {
        musicSwitch.on = musicSetting;
    }
    else
    {
        musicSwitch.on = false;
    }
}

// HIDE KEYBOARD WHEN ENTER IS HIT
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userName resignFirstResponder];
    return YES;
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button != nil)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(IBAction)onSave:(id)sender
{
    NSString *userNameString = userName.text;
    if (userNameString != nil)
    {
        [userDefaults setObject:userNameString forKey:@"username"];
    }
    
    [userDefaults setBool:musicSwitch.on forKey:@"musicSetting"];
    

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
