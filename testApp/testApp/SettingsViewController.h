//
//  SettingsViewController.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/29/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *userName;
    IBOutlet UISwitch *musicSwitch;
    NSUserDefaults *userDefaults;
}

-(IBAction)onClick:(id)sender;
-(IBAction)onSave:(id)sender;

@end
