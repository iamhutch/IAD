//
//  GameOver.m
//  testApp
//
//  Created by Lucy Hutcheson on 12/1/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "GameOver.h"
#import "Start.h"
#import "LevelBase.h"

@implementation GameOver

// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	GameOver *layer = [GameOver node];
	
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
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                         priority:0
                                                  swallowsTouches:YES];
        
        

    }
    return self;
}
-(void) onEnter
{
    BOOL showAchievement = NO;
    
    // GET OUR CURRENT GAME LEVEL
    int _gameLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level"];
    
    // CALCULATE LOSSES
    if (_gameLevel == 1)
    {
        // PULL LOSSES FOR THIS GAME LEVEL
        losses = [[NSUserDefaults standardUserDefaults] integerForKey:@"LevelOneLosses"];
        if (losses > 1)
        {
            NSLog(@"LEVELONELOSSAWARD: %i", [[NSUserDefaults standardUserDefaults] integerForKey:@"LevelOneLossAward"]);
            // ONLY SHOW AWARD IF IT HASN'T BEEN SHOWN BEFORE
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"LevelOneLossAward"] == 0)
            {
                // SET BOOL TO YES TO SHOW OUR ACHIEVEMENT
                showAchievement = YES;
                
                // AWARD THE NEGATIVE ACHIEVEMENT
                [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"LevelOneLossAward"];
            }
        }
    }
    else if (_gameLevel == 2)
    {
        // PULL LOSSES FOR THIS GAME LEVEL
        losses = [[NSUserDefaults standardUserDefaults] integerForKey:@"LevelTwoLosses"];
        if (losses > 2)
        {
            // ONLY SHOW AWARD IF IT HASN'T BEEN SHOWN BEFORE
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"LevelTwoLossAward"] == 0)
            {
                // SET BOOL TO YES TO SHOW OUR ACHIEVEMENT
                showAchievement = YES;
                
                // AWARD THE NEGATIVE ACHIEVEMENT
                [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"LevelTwoLossAward"];
            }
            
        }
    }
    else if (_gameLevel ==3)
    {
        // PULL LOSSES FOR THIS GAME LEVEL
        losses = [[NSUserDefaults standardUserDefaults] integerForKey:@"LevelThreeLosses"];
        if (losses > 3)
        {
            // ONLY SHOW AWARD IF IT HASN'T BEEN SHOWN BEFORE
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"LevelThreeLossAward"] == 0)
            {
                // SET BOOL TO YES TO SHOW OUR ACHIEVEMENT
                showAchievement = YES;
                
                // AWARD THE NEGATIVE ACHIEVEMENT
                [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"LevelThreeLossAward"];
            }
        }
    }
    
    
    if (showAchievement){
        CCLabelTTF *congrats = [CCLabelTTF labelWithString:@"CONGRATULATIONS" fontName:@"Helvetica" fontSize:24];
        congrats.position = ccp(winSize.width*0.5f, winSize.height*0.68f);
        congrats.color = ccYELLOW;
        [self addChild:congrats];
        
        CCLabelTTF *achievement = [CCLabelTTF labelWithString:@"You have achieved\na substantial\namount of losses\nfor this level!\nGood job!" fontName:@"Helvetica" fontSize:21];
        achievement.position = ccp(winSize.width*0.5f, winSize.height*0.4f);
        achievement.color = ccYELLOW;
        [self addChild:achievement];
        
    }
    
    

}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node]]];
}


@end
