//
//  LeaderboardViewController.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/23/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "scores.h"

@interface LeaderboardViewController ()

@end

@implementation LeaderboardViewController
@synthesize leaderboardArray;

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

    leaderboardArray = [[NSMutableArray alloc] init];

    PFQuery *queryLevel1 = [PFQuery queryWithClassName:@"topscores"];
    [queryLevel1 orderByDescending:@"score"];
    [queryLevel1 whereKey:@"level" equalTo:@1];
    queryLevel1.limit = 1;
    level1Array = [queryLevel1 findObjects];
    [self.leaderboardArray addObjectsFromArray:level1Array];

    PFQuery *queryLevel2 = [PFQuery queryWithClassName:@"topscores"];
    [queryLevel2 orderByDescending:@"score"];
    [queryLevel2 whereKey:@"level" equalTo:@2];
    queryLevel2.limit = 1;
    level2Array = [queryLevel2 findObjects];
    [self.leaderboardArray addObjectsFromArray:level2Array];

    PFQuery *queryLevel3 = [PFQuery queryWithClassName:@"topscores"];
    [queryLevel3 orderByDescending:@"score"];
    [queryLevel3 whereKey:@"level" equalTo:@3];
    queryLevel3.limit = 1;
    level3Array = [queryLevel3 findObjects];
    [self.leaderboardArray addObjectsFromArray:level3Array];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (leaderboardArray != nil) {
        return leaderboardArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [scoreTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // FIRST LINE
    NSString *scoreUserName = [leaderboardArray objectAtIndex:indexPath.row][@"user"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", scoreUserName];
    
    // SECOND LINE
    NSString *scoreLevel = [leaderboardArray objectAtIndex:indexPath.row][@"level"];
    NSString *scoreScore = [leaderboardArray objectAtIndex:indexPath.row][@"score"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %@, Level: %@", scoreScore, scoreLevel];

    return cell;
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
