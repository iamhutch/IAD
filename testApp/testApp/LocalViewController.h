//
//  LocalViewController.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/25/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalViewController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *scoreTableView;
    NSMutableArray *leaderboardArray;
    NSString *scoreShareString;
}

@property (strong, nonatomic) NSString *scoreShareString;

-(IBAction)onClick:(id)sender;
-(IBAction)sortTable:(id)sender;
@end
