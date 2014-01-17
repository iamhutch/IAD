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
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// ADD BACKGROUND
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
