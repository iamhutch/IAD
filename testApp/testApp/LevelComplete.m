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
        defaults = [NSUserDefaults standardUserDefaults];
        
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (winSize.width > 480)
            {
                background = [CCSprite spriteWithFile:@"complete_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"complete.png"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (winSize.width > 1024)
            {
                background = [CCSprite spriteWithFile:@"complete_ipad_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"complete_ipad.png"];
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
    
    // GET OUR LAST SCORE AND LAST LEVEL
    float _score  = [defaults floatForKey:@"lastScore"];
    int _gameLevel = [defaults integerForKey:@"Level"];
    int _numberOfStars;
    
    switch(_gameLevel) {
            
        case 1:
            if (_score > 930)
            {
                _numberOfStars = 3;
            }
            else if (_score > 910 && _score < 929)
            {
                _numberOfStars = 2;
            }
            else if (_score > 500 && _score < 909)
            {
                _numberOfStars = 1;
            }
            
            // INCREASE GAME LEVEL FROM 1 TO 2
            [defaults setInteger:2 forKey:@"Level"];
            break;

        case 2:
            if (_score > 1700)
            {
                _numberOfStars = 3;
            }
            else if (_score > 1600 && _score < 1699)
            {
                _numberOfStars = 2;
            }
            else if (_score > 1000 && _score < 1599)
            {
                _numberOfStars = 1;
            }

            // INCREASE GAME LEVEL FROM 2 TO 3
            [defaults setInteger:3 forKey:@"Level"];
            break;

        case 3:
            if (_score > 2870)
            {
                _numberOfStars = 3;
            }
            else if (_score > 2700 && _score < 2869)
            {
                _numberOfStars = 2;
            }
            else if (_score > 2000 && _score < 2699)
            {
                _numberOfStars = 1;
            }
            
            // ONLY SHOW COMPLETION AWARD IF IT HASN'T BEEN SHOWN BEFORE
            if ([defaults integerForKey:@"CompletionAward"] == 0)
            {
                CCLabelTTF *congrats = [CCLabelTTF labelWithString:@"CONGRATULATIONS" fontName:@"Helvetica-Bold" fontSize:24];
                congrats.position = ccp(winSize.width*0.5f, winSize.height*0.38f);
                [self addChild:congrats];
                
                CCLabelTTF *achievement = [CCLabelTTF labelWithString:@"You have completed level 3! Outstanding!" fontName:@"Helvetica" fontSize:21];
                achievement.position = ccp(winSize.width*0.5f, winSize.height*0.3f);
                [self addChild:achievement];
                
                // INCREMENT THE COMPLETION ACHIEVEMENT
                [defaults setInteger:1 forKey:@"CompletionAward"];
            }

            // INCREASE GAME LEVEL FROM 3 TO 4
            [defaults setInteger:4 forKey:@"Level"];

            break;
            
        case 4:
            if (_score > 3700)
            {
                _numberOfStars = 3;
            }
            else if (_score > 3600 && _score < 3699)
            {
                _numberOfStars = 2;
            }
            else if (_score > 3400 && _score < 3599)
            {
                _numberOfStars = 1;
            }
            break;

    }
    
    if (_numberOfStars > 0)
    {
        // SAVE NUMBER OF STARS FOR INCREMENTAL ACHIEVEMENT
        int myStars = [defaults integerForKey:@"stars"] + _numberOfStars;
        [defaults setInteger:myStars forKey:@"stars"];
        
        if (myStars > 25)
        {
            int goldStar = [defaults integerForKey:@"GoldStar"];
            if (goldStar == 0) // WE HAVEN'T SEEN IT YET
            {
                // SHOW THIRD INCREMENTAL ACHIEVEMENT
                UIAlertView *showStarMsg = [[UIAlertView alloc] initWithTitle:@"CONGRATULATIONS" message:@"You've earned 25 stars!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                // SET AN INTEGER THAT WE HAVE AWARDED THIS ALREADY SO WE SHOW IT ONLY ONCE
                [defaults setInteger:1 forKey:@"GoldStar"];
                [showStarMsg show];
            }
        }
        else if (myStars > 15)
        {
            int silverStar = [defaults integerForKey:@"SilverStar"];
            if (silverStar == 0) // WE HAVEN'T SEEN IT YET
            {
                // SHOW SECOND INCREMENTAL ACHIEVEMENT
                UIAlertView *showStarMsg = [[UIAlertView alloc] initWithTitle:@"CONGRATULATIONS" message:@"You've earned 15 stars!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                // SET AN INTEGER THAT WE HAVE AWARDED THIS ALREADY SO WE SHOW IT ONLY ONCE
                [defaults setInteger:1 forKey:@"SilverStar"];
                [showStarMsg show];
            }
        }
        else if (myStars > 5)
        {
            int bronzeStar = [defaults integerForKey:@"BronzeStar"];
            if (bronzeStar == 0) // WE HAVEN'T SEEN IT YET
            {
                // SHOW FIRST INCREMENTAL ACHIEVEMENT
                UIAlertView *showStarMsg = [[UIAlertView alloc] initWithTitle:@"CONGRATULATIONS" message:@"You've earned 5 stars!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                // SET AN INTEGER THAT WE HAVE AWARDED THIS ALREADY SO WE SHOW IT ONLY ONCE
                [defaults setInteger:1 forKey:@"BronzeStar"];
                [showStarMsg show];
            }
        }

        
        // SHOW STARS FOR MEASUREMENT ACHIEVEMENT
        NSString *_starFile = [NSString stringWithFormat:@"%istars.png", _numberOfStars];
        CCSprite *_stars = [CCSprite spriteWithFile:_starFile];
        _stars.position = ccp(winSize.width*0.5, winSize.height*0.6);
        _stars.scale = 0.7;
        [self addChild:_stars];
    }
    
    NSString *scoreString = [NSString stringWithFormat:@"Score: %.0f", round(_score)];
    CCLabelTTF *finalScore = [CCLabelTTF labelWithString:scoreString fontName:@"Helvetica-Bold" fontSize:24];
    finalScore.position = ccp(winSize.width*0.5f, winSize.height*0.2f);
    [self addChild:finalScore];

    

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
