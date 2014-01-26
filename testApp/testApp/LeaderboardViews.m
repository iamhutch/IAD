//
//  LeaderboardViews.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/25/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LeaderboardViews.h"
#import "LocalViewController.h"
#import "LeaderboardViewController.h"
#import "Start.h"

@implementation LeaderboardViews

// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	LeaderboardViews *layer = [LeaderboardViews node];
	
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
        CCMenuItemImage *onlineMenu = [CCMenuItemImage itemWithNormalImage:@"menu_online.png"
                                                                  selectedImage:nil
                                                                         target:self
                                                                       selector:@selector(loadLeadershipView)
                                            ];
        onlineMenu.position = ccp(surface.width/4.0f, surface.height*0.35f);
        onlineMenu.tag = 0;
        onlineMenu.releaseBlockAtCleanup = NO;

        CCMenuItemImage *localMenu = [CCMenuItemImage itemWithNormalImage:@"menu_local.png"
                                                                  selectedImage:nil
                                                                         target:self
                                                                       selector:@selector(loadLocalView)
                                            ];
        localMenu.position = ccp(surface.width/4.0f, surface.height*0.20f);
        localMenu.tag = 1;
        localMenu.releaseBlockAtCleanup = NO;

        
        
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:24];
        backLabel.color = ccBLACK;
        
        CCMenuItem *backButton = [CCMenuItemLabel itemWithLabel:backLabel
                                                          block:^(id sender)  {
                                                              [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node]]];
                                                          }
                                  ];
        backButton.position = ccp(5.0f, surface.height*0.9f);

        
        CCMenu *menuStart = [CCMenu menuWithItems: backButton, nil];
        menuStart.position = CGPointZero;
        [self addChild:menuStart z:20];
        
        
    }
    return self;
}

- (void)loadLeadershipView
{
    LeaderboardViewController *leaderView = [[LeaderboardViewController alloc] init];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController pushViewController:leaderView animated:YES];
    // [[CCDirector sharedDirector] pause];
}

- (void)loadLocalView
{
    LocalViewController *localView = [[LocalViewController alloc] init];
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController pushViewController:localView animated:YES];
    // [[CCDirector sharedDirector] pause];
}






@end
