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
#import "CustomTableCell.h"
#import <Social/Social.h>

@interface LocalViewController ()

@end

@implementation LocalViewController
@synthesize scoreShareString;

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
    // IF WE HAVE SCORES, SHOW IT
    if (leaderboardArray != nil){
        return leaderboardArray.count;
    }
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"CustomTableCell";
    
    // setup table cells
    CustomTableCell *cell = (CustomTableCell*)[scoreTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
       // cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // IF WE HAVE SCORES, SHOW IT
    if (leaderboardArray != nil)
    {
        cell.titleLabel.text  = [NSString stringWithFormat:@"%@",((scores *) [leaderboardArray objectAtIndex:indexPath.row])._user];
        
        NSString *levelString = [NSString stringWithFormat:@"%@", ((scores *) [leaderboardArray objectAtIndex:indexPath.row])._level];
        NSString *scoreString = [NSString stringWithFormat:@"%@", ((scores *) [leaderboardArray objectAtIndex:indexPath.row])._score];
        scoreShareString = scoreString;
        cell.subTitleLabel.text = [NSString stringWithFormat:@"Score: %@, Level: %@", scoreString, levelString];
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setFrame:CGRectMake(500, 6, 50, 50)];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"social_share.png"] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:shareButton];

    }
    // OTHERWISE, SHOW AN EMPTY TEXT
    else
    {
        cell.titleLabel.text = @"No scores found.";
        cell.subTitleLabel.text = @"Please play one game first then come back. ";
    }
    
    
    return cell;
}

- (void)shareButtonPressed:(id)sender
{
    // Get indexPath so I know what data to share
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:scoreTableView];
    NSIndexPath *indexPath = [scoreTableView indexPathForRowAtPoint:buttonPosition];

    scoreShareString = [NSString stringWithFormat:@"%@", ((scores *) [leaderboardArray objectAtIndex:indexPath.row])._score];
    
    NSLog(@"Share button pressed.");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Post Cancelled" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [scoreTableView reloadData];
                    break;
                }
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Tweet was successfully posted." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [scoreTableView reloadData];
                    break;
                }
            }
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    //NSLog(@"Tweet Sheet has been dismissed.");
                }];
            });
        };
        
        [tweetSheet setInitialText:[NSString stringWithFormat:@"I scored %@!\n#WoodchuckRun", scoreShareString]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
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
