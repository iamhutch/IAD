//
//  Credits.m
//  testApp
//
//  Created by Lucy Hutcheson on 12/16/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "Credits.h"
#import "Start.h"


@implementation Credits

// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	Credits *layer = [Credits node];
	
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
                background = [CCSprite spriteWithFile:@"credits_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"credits.png"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (winSize.width > 1024)
            {
                background = [CCSprite spriteWithFile:@"credits_ipad_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"credits_ipad.png"];
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

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node]]];
}


@end
