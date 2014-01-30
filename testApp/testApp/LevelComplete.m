//
//  LevelComplete.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/30/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LevelComplete.h"
#import "Start.h"
#import "LevelOne.h"
#import "LevelTwo.h"
#import "LevelThree.h"

@implementation LevelComplete
// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	LevelComplete *layer = [LevelComplete node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
	if( (self=[super init])) {
        winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (winSize.width > 480)
            {
                background = [CCSprite spriteWithFile:@"gameover_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"gameover.png"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (winSize.width > 1024)
            {
                background = [CCSprite spriteWithFile:@"gameover_ipad_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"gameover_ipad.png"];
            }
        }
        
		background.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild: background];
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalImage:@"menu_backs.png"
                                                             selectedImage:nil
                                                                     block:^(id sender)  {
                                                                         [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node]]];
                                                                     }
                                       ];
        backButton.position = ccp(50.0f, winSize.height*0.45f);
        backButton.tag = 3;
        backButton.releaseBlockAtCleanup = NO;
        
        
        CCMenu *menuStart = [CCMenu menuWithItems: backButton, nil];
        menuStart.position = CGPointZero;
        [self addChild:menuStart z:20];

        [self measureAchievement];
        
    }
    return self;
}


- (void)measureAchievement
{
    
}

@end
