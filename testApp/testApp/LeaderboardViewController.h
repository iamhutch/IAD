//
//  LeaderboardViewController.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/23/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LeaderboardViewController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *scoreTableView;
    NSArray *level1Array;
    NSArray *level2Array;
    NSArray *level3Array;
    NSArray *level4Array;
    NSMutableArray *leaderboardArray;
}

@property (nonatomic, retain) NSMutableArray *leaderboardArray;

-(IBAction)onClick:(id)sender;

@end
