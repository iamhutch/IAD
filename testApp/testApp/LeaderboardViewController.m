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

    PFQuery *queryLevel1 = [PFQuery queryWithClassName:@"topscores"];
    [queryLevel1 orderByDescending:@"score"];

    resultArray = [queryLevel1 findObjects];
    
    /*[queryLevel1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                [resultArray addObject:object];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultArray.count;
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
    NSString *scoreUserName = [resultArray objectAtIndex:indexPath.row][@"user"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", scoreUserName];
    
    // SECOND LINE
    NSString *scoreLevel = [resultArray objectAtIndex:indexPath.row][@"level"];
    NSString *scoreScore = [resultArray objectAtIndex:indexPath.row][@"score"];
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
