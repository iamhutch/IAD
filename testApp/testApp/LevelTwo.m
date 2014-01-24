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
        
        winSize = [CCDirector sharedDirector].winSize;
        surface = [CCDirector sharedDirector].winSizeInPixels;
        baseLevel = [[LevelBase alloc] init];
        saveScoreOnce = 0;


        // BACKGROUND
        background = baseLevel._background;
        foreground = baseLevel._foreground;
		[self addChild:background z:0];
        [self addChild:foreground z:1];
        
        
        // PROGRESS BAR AT THE TOP AS AN EVENT
        bar = baseLevel._bar;
        [self addChild:bar z:5];
        
        
        // LEVEL LABEL
        CCLabelTTF *levelLabel = baseLevel._levelLabel;
        levelLabel.string = @"Level 2";
        [self addChild:levelLabel];
        // -- TIMER LABEL
        timerLabel = [CCLabelTTF labelWithString:@"0:00" fontName:@"Helvetica" fontSize:18];
        timerLabel.position = ccp(winSize.width*0.05f, winSize.height*0.90f);
        [self addChild:timerLabel];
       
        
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
        wood = baseLevel._wood; // PILE 1
        [self addChild:wood z:11];
        wood2 = baseLevel._wood2; // PILE 2
        [self addChild:wood2 z:11];
       
        
        // FARMER TRACTOR ANIMATION
        tractor = baseLevel._tractor;
        [self addChild:tractor z:10];
        
        
        // SETUP TICK
        [self schedule:@selector(tick:) interval:1.0f/60.0f];
        
        [self sendWoodChuck];  // START OUR WOODCHUCK WALKING
        [self sendTractor];  // START OUR TRACTOR ROLLING
        [self sendWood];
        
        // RESET TIMER AND START IT
        timer = 0;
        _scoreTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(increaseTimer)
                                                     userInfo:nil
                                                      repeats:YES];

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
    [woodchuckWalk runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(woodchuckWalk.position, CGPointMake(winSize.width*0.5f, winSize.height), 1).x-80, winSize.height*0.20)]];
    [woodchuckWalk setVisible:YES];
    [woodchuckHit runAction:[CCMoveTo actionWithDuration:4.0 position:ccp(ccpLerp(woodchuckWalk.position, CGPointMake(winSize.width*0.5f, winSize.height), 1).x-80, winSize.height*0.20)]];
    [woodchuckHit setVisible:NO];
}

// START WOOD MOVING WITH ROAD
- (void)sendWood
{
    [wood runAction:[CCMoveTo actionWithDuration:4.0f position:ccp(ccpLerp(wood.position, CGPointMake(winSize.width*0.5, winSize.height), 1).x, winSize.height*0.20)]];
    
    [wood2 runAction:[CCMoveTo actionWithDuration:4.0f position:ccp(ccpLerp(wood2.position, CGPointMake(winSize.width*0.75, winSize.height), 1).x, winSize.height*0.20)]];
}


// START TRACTOR ROLLING
- (void)sendTractor
{
    [tractor runAction:[CCMoveTo actionWithDuration:20.0 position:ccp(winSize.width + tractor.contentSize.width, winSize.height*0.35)]];
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
        else if (CGRectIntersectsRect(_playerRect, _woodRect2))
        {
            CCTexture2D *newTexture2 = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"wood-%d.png", _woodCount]];
            [[SimpleAudioEngine sharedEngine] playEffect:@"crunch.caf"];
            wood2.texture = newTexture2;
            if (_woodCount < 9){
                _woodCount++;
            }
        }
        else {
            _woodCount = 0;
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

// RETURN THE CGRECT OF OUR 2ND WOOD PILE
-(CGRect)rectWood2
{
    return CGRectMake(wood2.position.x - (wood2.contentSize.width/2),
                      wood2.position.y - (wood2.contentSize.height/2),
                      wood2.contentSize.width-80, wood2.contentSize.height);
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
    
    position1.x -= 1.0f;
    position2.x -= 2.5f;
    
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
    _woodRect2 = [self rectWood2];
    
    // CHECK IF WOODCHUCK HAS MET UP WITH WOODPILE
    if ((CGRectIntersectsRect(_playerRect, _woodRect)) || (CGRectIntersectsRect(_playerRect, _woodRect2)))
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
        
        if (saveScoreOnce == 0)
        {
            // GET USERNAME
            NSArray *_hostNameArray = [[NSHost currentHost] names];
            username = [_hostNameArray objectAtIndex:0];
            
            // CALCULATE SCORE BEFORE LEVEL IS INCREASED
            _score = [baseLevel calculateScore:(float)timer];
            _gameLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level"];
            
            PFObject *scoreObject = [PFObject objectWithClassName:@"topscores"];
            scoreObject[@"user"] = username;
            scoreObject[@"score"] = [NSNumber numberWithFloat:_score];
            scoreObject[@"level"] = [NSNumber numberWithInt:_gameLevel];
            [scoreObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    // The gameScore saved successfully.
                    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[Start node] ]];
                } else {
                    // There was an error saving the gameScore.
                    NSLog(@"%@", error);
                }
            }];
            
            // INCREASE GAME LEVEL FROM 2 TO 3
            [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"Level"];
            
            saveScoreOnce++;
        }
    }
    
}

-(void)increaseTimer
{
    timer += 1;
    timerLabel.string = [NSString stringWithFormat:@":%i", timer];
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
