//
//  LevelBase.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/20/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "LevelBase.h"
#import "SimpleAudioEngine.h"

@implementation LevelBase

@synthesize _background, _foreground, woodchuckString, _barString, _barCGP, _barAnchorPoint, _bar, _levelLabel, _pauseMenu, _woodchuckHit, _woodchuckWalk, _tractor, _wood, _wood2, _woodchuckSlide, _fence;


- (id) init {
    
    self = [super init];
    
    // SETUP AUDIO, WINDOW SIZE
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"crunch.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];
    winSize = [CCDirector sharedDirector].winSize;
    surface = [CCDirector sharedDirector].winSizeInPixels;

    // BACKGROUND
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
    {
        if (surface.width > 480)
        {
            _background = [CCSprite spriteWithFile:@"bg-repeat1.png"];
            _background.position = ccp(winSize.width*0.25f, winSize.height*0.5f);

            _foreground = [CCSprite spriteWithFile:@"bg-repeat2.png"];
            _foreground.position = ccp(winSize.width, winSize.height*0.5f);
            
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim-hd.plist"];
           
        }
        else
        {
            _background = [CCSprite spriteWithFile:@"bg.png"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim.plist"];
        }
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (surface.width > 1024)
        {
            _background = [CCSprite spriteWithFile:@"bg_ipad_hd.png"];
        }
        else
        {
            _background = [CCSprite spriteWithFile:@"bg_ipad.png"];
        }
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"woodchuck-anim-hd.plist"];
    }
    
    _background.position = ccp(winSize.width*0.5f, winSize.height*0.5f);
    
    // PROGRESS BAR AT THE TOP AS AN EVENT
    _bar = [CCSprite spriteWithFile:@"bar.png"];
    _bar.position = ccp(0.0, winSize.height);
    _bar.anchorPoint = ccp(0.0, 0.5);
    
    // LEVEL LABEL
    _levelLabel = [CCLabelTTF labelWithString:@"Level 1" fontName:@"Helvetica" fontSize:24];
    _levelLabel.position = ccp(winSize.width*0.5f, winSize.height*0.85f);
    
    
    // CREATE MY BUTTONS
    CCMenuItem *pauseButton = [CCMenuItemImage itemWithNormalImage:@"button-pause.png" selectedImage:@"button-pause-selected.png" target:self selector:@selector(pauseButtonPressed:)];
    pauseButton.position = ccp(winSize.width-50, winSize.height-(winSize.height*0.10));
    _pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
    _pauseMenu.position = CGPointZero;

    
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
    CCAnimation *_walkingAnimation = [CCAnimation animationWithSpriteFrames:walkingFrames delay:0.25f];
    CCAction *_walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:_walkingAnimation]];
    [_woodchuckWalk runAction:_walkAction];
   
    _woodchuckHit = [CCSprite spriteWithSpriteFrameName:@"woodchuck-eat00.png"];
    _woodchuckHit.position = ccp(_woodchuckWalk.position.x, winSize.height*0.20);
    [_woodchuckHit setVisible:NO];
    CCAnimation *_collisionAnimation = [CCAnimation animationWithSpriteFrames:collisionFrames delay:0.5f];
    CCAction *_collisionAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:_collisionAnimation]];
    [_woodchuckHit runAction:_collisionAction];

 
    _woodchuckSlide = [CCSprite spriteWithFile:@"woodchuck-slide.png"];
    _woodchuckSlide.position = ccp(_woodchuckSlide.position.x, winSize.height*0.15);
    [_woodchuckSlide setVisible:NO];

    // FARMER TRACTOR ANIMATION
    NSMutableArray *tractorFrames = [NSMutableArray array];
    for (int i=0; i<=3; i++)
    {
        [tractorFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"tractor-%d.png", i]]];
    }
    
    _tractor = [CCSprite spriteWithSpriteFrameName:@"tractor-0.png"];
    _tractor.position = ccp(-(_tractor.contentSize.width), winSize.height*0.35);
    
    CCAnimation *tractorAnimation = [CCAnimation animationWithSpriteFrames:tractorFrames delay:0.25f];
    CCAction *tractorAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:tractorAnimation]];
    [_tractor runAction:tractorAction];

    // PILE OF WOOD
    _wood = [CCSprite spriteWithFile:@"wood.png"];
    _wood.position = ccp(winSize.width*0.75, winSize.height*0.2);
    _wood2 = [CCSprite spriteWithFile:@"wood.png"];
    _wood2.position = ccp(winSize.width, winSize.height*0.2);


    // FENCE OBSTACLE
    _fence = [CCSprite spriteWithFile:@"fence.png"];
    _fence.position = ccp(winSize.width*1.25f, winSize.height*0.2);

    
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
            _pauseMenu.scale = 0.5f;
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

// CALCULATE SCORE
- (float)calculateScore:(float)timerValue
{
    // GET OUR LEVEL TO DETERMINE VALUE OF POINT BASE
    int _gameLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level"];
    
    // FORMULA TO GET REALISTIC SCORE
    float _timerScore = ((100.0f - timerValue) * 0.01f);
    
    // SWITCH BASED ON GAME LEVEL JUST COMPLETED
    switch(_gameLevel) {
            
        case 1:
            _calculatedScore = 1000.0f * _timerScore;
            break;
        case 2:
            _calculatedScore = 2000.0f * _timerScore;
            break;
        case 3:
            _calculatedScore = 3000.0f * _timerScore;
            break;
    }
    NSLog(@"TIMERVALUE: %f", timerValue);
    return _calculatedScore;
}



@end
