//
//  LevelOne.m
//  testApp
//
//  Created by Lucy Hutcheson on 12/1/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "LevelOne.h"
#import "GameOver.h"
#import "Start.h"
#import "LevelBase.h"
#import "SimpleAudioEngine.h"

@implementation LevelOne


// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	LevelOne *layer = [LevelOne node];
	
	[scene addChild: layer];
	
	return scene;
}

// INITIALIZE
- (id) init
{
	if( (self=[super init])) {
        
        _woodCount = 0;
        
        winSize = [CCDirector sharedDirector].winSize;
        surface = [CCDirector sharedDirector].winSizeInPixels;
        
        // BACKGROUND
        LevelBase *baseLevel = [[LevelBase alloc] init];
        background = baseLevel._background;
        foreground = baseLevel._foreground;
		[self addChild:background z:0];
        [self addChild:foreground z:1];
        

        // PROGRESS BAR AT THE TOP AS AN EVENT
        bar = baseLevel._bar;
        [self addChild:bar z:5];
        
        
        // LEVEL LABEL
        CCLabelTTF *levelLabel = baseLevel._levelLabel;
        [self addChild:levelLabel];
        
        
        // CREATE MY BUTTONS
        CCMenu *pauseMenu = baseLevel._pauseMenu;
        [self addChild:pauseMenu z:10];
        gamePause = NO;
        
        
        // WOODCHUCK ANIMATIONS
        woodchuckWalk = baseLevel._woodchuckWalk;
        [self addChild:woodchuckWalk z:10];
        woodchuckHit = baseLevel._woodchuckHit;
        [self addChild:woodchuckHit z:10];

        
        // PILE OF WOOD
        wood = baseLevel._wood;
        [self addChild:wood z:11];
        
        
        // FARMER TRACTOR ANIMATION
        tractor = baseLevel._tractor;
        [self addChild:tractor z:10];
        
        
        // SETUP TICK
        [self schedule:@selector(tick:) interval:1.0f/60.0f];
        
        [self sendWoodChuck];  // START OUR WOODCHUCK WALKING
        [self sendTractor];  // START OUR TRACTOR ROLLING

        // ALLOW TOUCHES
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                         priority:0
                                                  swallowsTouches:YES];

    }
    return self;
}


// START WOODCHUCK WALKING WITH LINEAR INTERPOLATION
- (void)sendWoodChuck
{
    [woodchuckWalk runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(woodchuckWalk.position, wood.position, 1).x-80, winSize.height*0.20)]];
    [woodchuckWalk setVisible:YES];
    [woodchuckHit runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(woodchuckWalk.position, wood.position, 1).x-80, winSize.height*0.20)]];
    [woodchuckHit setVisible:NO];
}


// START TRACTOR ROLLING
- (void)sendTractor
{
    [tractor runAction:[CCMoveTo actionWithDuration:30.0 position:ccp(winSize.width + tractor.contentSize.width, winSize.height*0.35)]];
}

// START TOUCH
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

// ON TOUCH ENDED
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    // MAKE SURE WE ARE NOT IN PAUSE MODE
    if (gamePause == NO)
    {
        // CHECK IF WOODCHUCK HAS MET UP WITH WOODPILE
        if (CGRectIntersectsRect(_playerRect, _woodRect))
        {
            CCTexture2D *newTexture = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"wood-%d.png", _woodCount]];
            [[SimpleAudioEngine sharedEngine] playEffect:@"crunch.caf"];
            wood.texture = newTexture;
            if (_woodCount < 9){
                _woodCount++;
            }
        }
        [woodchuckWalk runAction: [CCMoveBy actionWithDuration:1 position:ccp(10,0)]];
        [woodchuckHit runAction: [CCMoveBy actionWithDuration:1 position:ccp(10,0)]];
    }

    
}

// RETURN THE CGRECT OF OUR WOODCHUCK
-(CGRect)rectPlayer
{
    return  CGRectMake(woodchuckWalk.position.x - (woodchuckWalk.contentSize.width/2),
                       woodchuckWalk.position.y - (woodchuckWalk.contentSize.height/2),
                       woodchuckWalk.contentSize.width, woodchuckWalk.contentSize.height);
}

// RETURN THE CGRECT OF OUR WOOD PILE
-(CGRect)rectWood
{
    return CGRectMake(wood.position.x - (wood.contentSize.width/2),
                      wood.position.y - (wood.contentSize.height/2),
                      wood.contentSize.width-80, wood.contentSize.height);
}

// RETURN THE CGRECT OF THE FARMER'S TRACTOR
-(CGRect)rectTractor
{
    return CGRectMake(tractor.position.x - (tractor.contentSize.width/2),
                      tractor.position.y - (tractor.contentSize.height/2),
                      tractor.contentSize.width+20.0f, tractor.contentSize.height);
}

// MOVE OUR BACKGROUND
-(void) scrollBackgound:(ccTime)dt
{
    CGPoint position1 = background.position;
    CGPoint position2 = foreground.position;
    
    position1.x -= 0.5f;
    position2.x -= 1.5f;
    
    background.position = position1;
    foreground.position = position2;

}

// CHECK THE STATUS OF OUR SPRITES
-(void) tick:(ccTime) dt {
    
    //NSLog(@"WOODCHUCK WALK POSITION: %f", (float)_woodchuckWalk.position.x);
    [self scrollBackgound:dt];
    
    bar.scaleX = (float) woodchuckWalk.position.x - woodchuckWalk.contentSize.width/2;

    _playerRect = [self rectPlayer];
    _woodRect = [self rectWood];
    _tractorRect = [self rectTractor];
    
    // CHECK IF WOODCHUCK HAS MET UP WITH WOODPILE
    if (CGRectIntersectsRect(_playerRect, _woodRect))
    {
        [woodchuckWalk setVisible:NO];
        [woodchuckHit setVisible:YES];
    }
    else
    {
        [woodchuckHit setVisible:NO];
        [woodchuckWalk setVisible:YES];
    }
    
    // IF WOODCHUCK IS NOT OFFSCREEN AND TRACTOR INTERSECTS WITH WOODCHUCK,
    // PLAY GAME OVER SONG AND SHOW GAME OVER SCREEN
    if ((woodchuckWalk.position.x < winSize.width) && (CGRectIntersectsRect(_tractorRect, _playerRect)))
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.2f];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOver node] ]];
    }
    
    // IF WOODCHUCK IS SAFELY OFFSCREEN, TAKE US BACK TO START
    if (woodchuckWalk.position.x > winSize.width) {
        // INCREASE GAME LEVEL FROM 1 TO 2
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"Level"];
        _gameLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level"];
        
        NSLog(@"CURRENT GAME LEVEL: %i", _gameLevel);
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node] ]];
    }
    
}

- (void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];

	[super dealloc];
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation]; // call this to make sure you don't start a second display link!
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] startAnimation];
}


@end
