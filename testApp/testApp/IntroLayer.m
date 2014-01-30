//
//  IntroLayer.m
//  testApp
//
//  Created by Lucy Hutcheson on 11/30/13.
//  Copyright Lucy Hutcheson 2013. All rights reserved.
//

#import "IntroLayer.h"
#import "Start.h"


@implementation IntroLayer

// CREATE THE SCENE AND LAYER WITH INTROLAYER AS CHILD
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	IntroLayer *layer = [IntroLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

// INITIALIZE LAYER
-(id) init
{
	if( (self=[super init])) {

		// GET THE WINDOW SIZE
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGSize surface = [CCDirector sharedDirector].winSizeInPixels;

		CCSprite *background;
		
        // SETUP BACKGROUND
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (surface.width > 480)
            {
                background = [CCSprite spriteWithFile:@"Default-568h@2x.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"Default@2x.png"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
        }
        
		background.position = ccp(winSize.width/2.0f, winSize.height/2.0f);
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Start scene] ]];
}
@end
