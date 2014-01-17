//
//  WoodChuckLayer.h
//  testApp
//
//  Created by Lucy Hutcheson on 12/1/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"


@interface WoodChuckGame : CCLayer
{
    CGSize surface;
    CGSize winSize;
    CCSprite *_woodchuckWalk;
    CCSprite *_woodchuckHit;
    CCSprite *_wood;
    CCSprite *_tractor;
    CGRect _playerRect;
    CGRect _woodRect;
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
}

@property (nonatomic, strong) CCSprite *_woodchuckWalk;
@property (nonatomic, strong) CCSprite *_woodchuckHit;
@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *collisionAction;
@property (nonatomic, strong) CCAnimation *walkingAnimation;
@property (nonatomic, strong) CCAnimation *collisionAnimation;


+(CCScene *) scene;

@end
