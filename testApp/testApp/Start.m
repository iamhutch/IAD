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
#import "SettingsViewController.h"
#import "HelpAndCredits.h"
#import "LeaderboardViews.h"
#import "LevelFour.h"



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
        startMenu.position = ccp(surface.width/4.0f, surface.height*0.42f);
        startMenu.tag = 0;
        startMenu.releaseBlockAtCleanup = NO;
        startMenu.scale = 0.9;

        CCMenuItemImage *settingMenu = [CCMenuItemImage itemWithNormalImage:@"menu_settings.png"
                                                            selectedImage:nil
                                                                     target:self
                                                                   selector:@selector(loadSettings)
                                      ];
        settingMenu.position = ccp(surface.width/4.0f, surface.height*0.31f);
        settingMenu.tag = 1;
        settingMenu.releaseBlockAtCleanup = NO;
        settingMenu.scale = 0.9;

        CCMenuItemImage *leaderboardMenu = [CCMenuItemImage itemWithNormalImage:@"menu_leaderboards.png"
                                                           selectedImage:nil
                                                                   block:^(id sender)  {
                                                                       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[LeaderboardViews node]]];
                                                                   }
                                     ];
        leaderboardMenu.position = ccp(surface.width/4.0f, surface.height*0.2f);
        leaderboardMenu.tag = 2;
        leaderboardMenu.releaseBlockAtCleanup = NO;
        leaderboardMenu.scale = 0.75;

        CCMenuItemImage *helpCreditsMenu = [CCMenuItemImage itemWithNormalImage:@"menu_helpcredits.png"
                                                             selectedImage:nil
                                                                          block:^(id sender)  {
                                                                              [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HelpAndCredits node]]];
                                                                          }
                                       ];
        helpCreditsMenu.position = ccp(surface.width/4.0f, surface.height*0.11f);
        helpCreditsMenu.tag = 3;
        helpCreditsMenu.releaseBlockAtCleanup = NO;
        helpCreditsMenu.scale = 0.75;
        

        
        CCMenu *menuStart = [CCMenu menuWithItems:startMenu, helpCreditsMenu, settingMenu, leaderboardMenu, nil];
        menuStart.position = CGPointZero;
        [self addChild:menuStart z:20];
        

        
    }
    return self;
}

- (void)onEnterTransitionDidFinish
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"musicSetting"])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music.caf"];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
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
        case 4:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[LevelFour node]]];
            break;
    }
}

- (void)loadSettings
{
    SettingsViewController *settingsView = [[SettingsViewController alloc] init];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController pushViewController:settingsView animated:YES];
   // [[CCDirector sharedDirector] pause];
}



@end
