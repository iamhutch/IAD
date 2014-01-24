//
//  Start.m
//  testApp
//
//  Created by Lucy Hutcheson on 12/2/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "Start.h"
#import "LevelOne.h"
#import "LevelTwo.h"
#import "LevelThree.h"
#import "Credits.h"
#import "Help.h"
#import "LeaderboardViewController.h"

@implementation Start

// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	Start *layer = [Start node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
	if( (self=[super init])) {
        winSize = [CCDirector sharedDirector].winSize;
        surface = [CCDirector sharedDirector].winSizeInPixels;
        CCSprite *background;
		
        // SETUP BACKGROUND
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (surface.width > 480)
            {
                background = [CCSprite spriteWithFile:@"start_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"start.png"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (surface.width > 1024)
            {
                background = [CCSprite spriteWithFile:@"start_ipad_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"start_ipad.png"];
            }
        }

		background.position = ccp(winSize.width/2.0f, winSize.height/2.0f);
		[self addChild: background];

        // SETUP MENUS WITH BLOCKS
        CCMenuItemImage *startMenu = [CCMenuItemImage itemWithNormalImage:@"menu_start.png"
                                                            selectedImage:nil
                                                                   target:self
                                                                 selector:@selector(startLevel:)
                                      ];
        startMenu.position = ccp(surface.width/4.0f, surface.height*0.4f);
        startMenu.tag = 0;

        CCMenuItemImage *helpMenu = [CCMenuItemImage itemWithNormalImage:@"menu_help.png"
                                                            selectedImage:nil
                                                                    block:^(id sender)  {
                                                                        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Help node]]];
                                                                    }
                                      ];
        helpMenu.position = ccp(surface.width/4.0f, surface.height*0.29f);
        helpMenu.tag = 1;

        CCMenuItemImage *creditMenu = [CCMenuItemImage itemWithNormalImage:@"menu_credits.png"
                                                           selectedImage:nil
                                                                   block:^(id sender)  {
                                                                       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Credits node]]];
                                                                   }
                                     ];
        creditMenu.position = ccp(surface.width/4.0f, surface.height*0.19f);
        creditMenu.tag = 2;

        CCMenuItemImage *leaderboardMenu = [CCMenuItemImage itemWithNormalImage:@"menu_leaderboard.png"
                                                             selectedImage:nil
                                                                    target:self
                                                                  selector:@selector(loadLeadershipView)
                                       ];
        leaderboardMenu.position = ccp(surface.width/4.0f, surface.height*0.07f);
        leaderboardMenu.tag = 3;
        

        
        CCMenu *menuStart = [CCMenu menuWithItems:startMenu, helpMenu, creditMenu, leaderboardMenu, nil];
        menuStart.position = CGPointZero;
        [self addChild:menuStart z:10];

        
    }
    return self;
}


- (void)startLevel:(CCMenuItem  *) menuItem
{
    int currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level"];
    NSLog(@"CURRENT LEVEL: %i", currentLevel);
    switch (currentLevel) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[LevelOne node]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[LevelTwo node]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[LevelThree node]]];
            break;
            
        default:
            break;
    }
}
- (void)loadLeadershipView
{
    LeaderboardViewController *leaderView = [[LeaderboardViewController alloc] init];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController pushViewController:leaderView animated:YES];
    [[CCDirector sharedDirector] pause];
}



@end
