//
//  LevelTwo.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/18/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LevelTwo.h"
#import "GameOver.h"
#import "Start.h"

@implementation LevelTwo
@synthesize _woodchuckWalk, _woodchuckHit, collisionAction, walkAction, walkingAnimation, collisionAnimation;

// SETUP SCENE
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	LevelTwo *layer = [LevelTwo node];
	
	[scene addChild: layer];
	
	return scene;
}

// INITIALIZE
- (id) init
{
	if( (self=[super init])) {
        
        _woodCount = 0;
        
        // SETUP AUDIO, WINDOW SIZE, BACKGROUND
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"crunch.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];
        winSize = [CCDirector sharedDirector].winSize;
        surface = [CCDirector sharedDirector].winSizeInPixels;
        
        // BACKGROUND        
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (surface.width > 480)
            {
                background = [CCSprite spriteWithFile:@"bg-repeat1.png"];
                background.position = ccp(winSize.width, winSize.height*0.5f);
                
                foreground = [CCSprite spriteWithFile:@"bg-repeat2.png"];
                foreground.position = ccp(winSize.width, winSize.height*0.5f);
                
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim-hd.plist"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"bg.png"];
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim.plist"];
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (surface.width > 1024)
            {
                background = [CCSprite spriteWithFile:@"bg_ipad_hd.png"];
            }
            else
            {
                background = [CCSprite spriteWithFile:@"bg_ipad.png"];
            }
            
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim-hd.plist"];
        }
        
		background.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild: background z:0];
        [self addChild:foreground z:1];
        
        // PROGRESS BAR AT THE TOP AS AN EVENT
        _bar = [CCSprite spriteWithFile:@"bar.png"];
        _bar.position = ccp(0.0, winSize.height);
        _bar.anchorPoint = ccp(0.0,0.5);
        [self addChild:_bar z:5];
        
        // LEVEL LABEL
        CCLabelTTF *levelLabel = [CCLabelTTF labelWithString:@"Level 2" fontName:@"Helvetica" fontSize:24];
        levelLabel.position = ccp(winSize.width*0.5f, winSize.height*0.85f);
        [self addChild:levelLabel];
        
        // CREATE MY BUTTONS
        CCMenuItem *pauseButton = [CCMenuItemImage itemWithNormalImage:@"button-pause.png" selectedImage:@"button-pause-selected.png" target:self selector:@selector(pauseButtonPressed:)];
        pauseButton.position = ccp(winSize.width-50, winSize.height-(winSize.height*0.10));
        CCMenu *pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
        pauseMenu.position = CGPointZero;
        [self addChild:pauseMenu z:10];
        gamePause = NO;
        
        
        
        // WOODCHUCK ANIMATIONS ================================
        NSMutableArray *walkingFrames = [NSMutableArray array];
        NSMutableArray *collisionFrames = [NSMutableArray array];
        for (int i=0; i<=1; i++)
        {
            [walkingFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"woodchuck-walking0%d.png", i]]];
            [collisionFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"woodchuck-eat0%d.png", i]]];
        }
        
        _woodchuckWalk = [CCSprite spriteWithSpriteFrameName:@"woodchuck-walking00.png"];
        _woodchuckWalk.position = ccp(_woodchuckWalk.contentSize.width/2, winSize.height*0.20);
        [_woodchuckWalk setVisible:YES];
        [self addChild:_woodchuckWalk z:10];
        
        _woodchuckHit = [CCSprite spriteWithSpriteFrameName:@"woodchuck-eat00.png"];
        _woodchuckHit.position = ccp(_woodchuckWalk.position.x, winSize.height*0.20);
        [_woodchuckHit setVisible:NO];
        [self addChild:_woodchuckHit z:10];
        
        walkingAnimation = [CCAnimation animationWithSpriteFrames:walkingFrames delay:0.25f];
        walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkingAnimation]];
        [_woodchuckWalk runAction:walkAction];
        
        collisionAnimation = [CCAnimation animationWithSpriteFrames:collisionFrames delay:0.5f];
        collisionAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:collisionAnimation]];
        [_woodchuckHit runAction:collisionAction];
        
        
        
        // PILE OF WOOD
        _wood = [CCSprite spriteWithFile:@"wood.png"];
        _wood.position = ccp(winSize.width*0.75, winSize.height*0.2);
        
        _wood2 = [CCSprite spriteWithFile:@"wood.png"];
        _wood2.position = ccp(winSize.width, winSize.height*0.2);

        [self addChild:_wood z:11];
        [self addChild:_wood2 z:11];
        
        
        // FARMER TRACTOR ANIMATION
        NSMutableArray *tractorFrames = [NSMutableArray array];
        for (int i=0; i<=3; i++)
        {
            [tractorFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"tractor-%d.png", i]]];
        }
        
        _tractor = [CCSprite spriteWithSpriteFrameName:@"tractor-0.png"];
        _tractor.position = ccp(-(_tractor.contentSize.width), winSize.height*0.35);
        [self addChild:_tractor z:10];
        
        tractorAnimation = [CCAnimation animationWithSpriteFrames:tractorFrames delay:0.25f];
        tractorAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:tractorAnimation]];
        [_tractor runAction:tractorAction];
        
        
        // START OUR WOODCHUCK WALKING AND TRACTOR ROLLING
        [self sendWoodChuck];
        [self sendTractor];
        [self sendWood];
        
        // SETUP TICK
        [self schedule:@selector(tick:) interval:1.0f/60.0f];
        
        // ALLOW TOUCHES
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                                  priority:0
                                                           swallowsTouches:YES];
        
        // SET SCALINGS
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            if (surface.width > 480)
            {
                _woodchuckWalk.scale = 1.5f;
                _woodchuckHit.scale = 1.5f;
                _wood.scale = 1.0f;
                _tractor.scale = 1.5f;
            }
            else
            {
                _woodchuckWalk.scale = 1.0f;
                _woodchuckHit.scale = 1.0f;
                _wood.scale = 0.3f;
                _tractor.scale = 1.0f;
                pauseMenu.scale = 0.5f;
            }
		}
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (surface.width > 1024)
            {
                _woodchuckWalk.scale = 3.0f;
                _woodchuckHit.scale = 3.0f;
                _wood.scale = 1.5f;
                _tractor.scale = 2.8f;
            }
            else
            {
                _woodchuckWalk.scale = 2.0f;
                _woodchuckHit.scale = 2.0f;
                _wood.scale = 1.0f;
                _tractor.scale = 1.8f;
            }
        }
        
    }
    return self;
}

// WHEN PAUSE BUTTON IS PRESSED, TOGGLE THE PAUSE FUNCTIONS
- (void)pauseButtonPressed:(id)sender
{
    if (gamePause == NO)
    {
        [[CCDirector sharedDirector] stopAnimation];
        [[CCDirector sharedDirector] pause];
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        gamePause = YES;
    }
    else
    {
        [[CCDirector sharedDirector] stopAnimation];
        [[CCDirector sharedDirector] resume];
        [[CCDirector sharedDirector] startAnimation];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        gamePause = NO;
    }
}

// START WOODCHUCK WALKING WITH LINEAR INTERPOLATION
- (void)sendWoodChuck
{
    [_woodchuckWalk runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(_woodchuckWalk.position, CGPointMake(winSize.width*0.5f, winSize.height), 1).x-80, winSize.height*0.20)]];
    [_woodchuckWalk setVisible:YES];
    [_woodchuckHit runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(_woodchuckWalk.position, CGPointMake(winSize.width*0.5f, winSize.height), 1).x-80, winSize.height*0.20)]];
    [_woodchuckHit setVisible:NO];
}

// START WOOD MOVING WITH ROAD
- (void)sendWood
{
    [_wood runAction:[CCMoveTo actionWithDuration:4.0f position:ccp(ccpLerp(_wood.position, CGPointMake(winSize.width*0.5, winSize.height), 1).x, winSize.height*0.20)]];
    
    [_wood2 runAction:[CCMoveTo actionWithDuration:4.0f position:ccp(ccpLerp(_wood.position, CGPointMake(winSize.width*0.75, winSize.height), 1).x, winSize.height*0.20)]];
}


// START TRACTOR ROLLING
- (void)sendTractor
{
    [_tractor runAction:[CCMoveTo actionWithDuration:20.0 position:ccp(winSize.width + _tractor.contentSize.width, winSize.height*0.35)]];
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
            _wood.texture = newTexture;
            if (_woodCount < 9){
                _woodCount++;
            }
        }
        else if (CGRectIntersectsRect(_playerRect, _woodRect2))
        {
            CCTexture2D *newTexture2 = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"wood-%d.png", _woodCount]];
            [[SimpleAudioEngine sharedEngine] playEffect:@"crunch.caf"];
            _wood2.texture = newTexture2;
            if (_woodCount < 9){
                _woodCount++;
            }
        }
        else {
            _woodCount = 0;
        }

        [_woodchuckWalk runAction: [CCMoveBy actionWithDuration:1 position:ccp(10,0)]];
        [_woodchuckHit runAction: [CCMoveBy actionWithDuration:1 position:ccp(10,0)]];
    }
    
    
}

// RETURN THE CGRECT OF OUR WOODCHUCK
-(CGRect)rectPlayer
{
    return  CGRectMake(_woodchuckWalk.position.x - (_woodchuckWalk.contentSize.width/2),
                       _woodchuckWalk.position.y - (_woodchuckWalk.contentSize.height/2),
                       _woodchuckWalk.contentSize.width, _woodchuckWalk.contentSize.height);
}

// RETURN THE CGRECT OF OUR WOOD PILE
-(CGRect)rectWood
{
    return CGRectMake(_wood.position.x - (_wood.contentSize.width/2),
                      _wood.position.y - (_wood.contentSize.height/2),
                      _wood.contentSize.width-80, _wood.contentSize.height);
}

// RETURN THE CGRECT OF OUR 2ND WOOD PILE
-(CGRect)rectWood2
{
    return CGRectMake(_wood2.position.x - (_wood2.contentSize.width/2),
                      _wood2.position.y - (_wood2.contentSize.height/2),
                      _wood2.contentSize.width-80, _wood2.contentSize.height);
}

// RETURN THE CGRECT OF THE FARMER'S TRACTOR
-(CGRect)rectTractor
{
    return CGRectMake(_tractor.position.x - (_tractor.contentSize.width/2),
                      _tractor.position.y - (_tractor.contentSize.height/2),
                      _tractor.contentSize.width+20.0f, _tractor.contentSize.height);
}


// MOVE OUR BACKGROUND
-(void) scrollBackgound:(ccTime)dt
{
    CGPoint position1 = background.position;
    CGPoint position2 = foreground.position;
    
    position1.x -= 1.0f;
    position2.x -= 2.5f;
    
    background.position = position1;
    foreground.position = position2;
    
}

// CHECK THE STATUS OF OUR SPRITES
-(void) tick:(ccTime) dt {
    
    //NSLog(@"WOODCHUCK WALK POSITION: %f", (float)_woodchuckWalk.position.x);
    [self scrollBackgound:dt];
    
    _bar.scaleX = (float) _woodchuckWalk.position.x - _woodchuckWalk.contentSize.width/2;
    
    _playerRect = [self rectPlayer];
    _woodRect = [self rectWood];
    _tractorRect = [self rectTractor];
    _woodRect2 = [self rectWood2];
    
    // CHECK IF WOODCHUCK HAS MET UP WITH WOODPILE
    if ((CGRectIntersectsRect(_playerRect, _woodRect)) || (CGRectIntersectsRect(_playerRect, _woodRect2)))
    {
        [_woodchuckWalk setVisible:NO];
        [_woodchuckHit setVisible:YES];
    }
    else
    {
        [_woodchuckHit setVisible:NO];
        [_woodchuckWalk setVisible:YES];
    }
    
    // IF WOODCHUCK IS NOT OFFSCREEN AND TRACTOR INTERSECTS WITH WOODCHUCK,
    // PLAY GAME OVER SONG AND SHOW GAME OVER SCREEN
    if ((_woodchuckWalk.position.x < winSize.width) && (CGRectIntersectsRect(_tractorRect, _playerRect)))
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.2f];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOver node] ]];
    }
    
    // IF WOODCHUCK IS SAFELY OFFSCREEN, TAKE US BACK TO START
    if (_woodchuckWalk.position.x > winSize.width) {
        // INCREASE GAME LEVEL FROM 2 TO 3
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"Level"];
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
