//
//  LevelTwo.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/18/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"

@interface LevelTwo : CCLayer
{
    CGSize surface;
    CGSize winSize;
    CCSprite *_woodchuckWalk;
    CCSprite *_woodchuckHit;
    CCSprite *_wood;
    CCSprite *_wood2;
    CCSprite *_tractor;
    CGRect _playerRect;
    CGRect _woodRect;
    CGRect _woodRect2;
    CGRect _tractorRect;
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

}

@property (nonatomic, strong) CCSprite *_woodchuckWalk;
@property (nonatomic, strong) CCSprite *_woodchuckHit;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *collisionAction;
@property (nonatomic, strong) CCAnimation *walkingAnimation;
@property (nonatomic, strong) CCAnimation *collisionAnimation;


+(CCScene *) scene;

@end
