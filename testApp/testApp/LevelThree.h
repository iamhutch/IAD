//
//  LevelThree.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/18/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface LevelThree : CCLayer
{
    CGSize surface;
    CGSize winSize;
    CCSprite *_woodchuckWalk;
    CCSprite *_woodchuckHit;
    CCSprite *_woodchuckSlide;
    CCSprite *_wood;
    CCSprite *_tractor;
    CCSprite *_fence;
    CGRect _playerRect;
    CGRect _woodRect;
    CGRect _woodRect2;
    CGRect _tractorRect;
    CGRect _fenceRect;
    CCAnimation *walkingAnimation;
    CCAnimation *collisionAnimation;
    CCAnimation *tractorAnimation;
    CCAction *walkAction;
    CCAction *collisionAction;
    CCAction *tractorAction;
    BOOL woodchuckWalk;
    CCSprite *_bar;
    bool gamePause;
    int _woodCount;
    int _gameLevel;
    CCSprite *background;
    CCSprite *foreground;
    id _woodchuckAction;
    id _woodchuckAction2;
    id _woodchuckAction3;
}

@property (nonatomic, strong) CCSprite *_woodchuckWalk;
@property (nonatomic, strong) CCSprite *_woodchuckHit;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *collisionAction;
@property (nonatomic, strong) CCAnimation *walkingAnimation;
@property (nonatomic, strong) CCAnimation *collisionAnimation;


+(CCScene *) scene;

@end
