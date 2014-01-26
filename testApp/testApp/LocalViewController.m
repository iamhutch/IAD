//
//  LocalViewController.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/25/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LocalViewController.h"
#import "DBManager.h"
#import "scores.h"

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
    
    leaderboardArray = [[NSMutableArray alloc] init];
    leaderboardArray = [[DBManager getSharedInstance] findByColumn:nil findByFilter:nil showAll:YES orderBy:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return leaderboardArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    // setup table cells
    UITableViewCell *cell = [scoreTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text  = [NSString stringWithFormat:@"%@",((scores *) [leaderboardArray objectAtIndex:indexPath.row])._user];
    
    NSString *levelString = [NSString stringWithFormat:@"%@", ((scores *) [leaderboardArray objectAtIndex:indexPath.row])._level];
    NSString *scoreString = [NSString stringWithFormat:@"%@", ((scores *) [leaderboardArray objectAtIndex:indexPath.row])._score];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %@, Level: %@", scoreString, levelString];
    
    return cell;
}

-(IBAction)sortTable:(id)sender
{
    [leaderboardArray removeAllObjects];
    leaderboardArray = [[DBManager getSharedInstance] findByColumn:NULL findByFilter:NULL showAll:NULL orderBy:@"score"];
    [scoreTableView reloadData];

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
