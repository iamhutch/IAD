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
    CCSprite *background;
    CCSprite *foreground;
    CCSprite *bar;
    CCSprite *wood;
    CCSprite *wood2;
    CCSprite *tractor;
    CGRect _playerRect;
    CGRect _woodRect;
    CGRect _tractorRect;
    CCAction *tractorAction;
    bool gamePause;
    int _woodCount;
    int _gameLevel;
    CCSprite *woodchuckWalk;
    CCSprite *woodchuckHit;

    CCSprite *woodchuckSlide;
    CCSprite *fence;
    CGRect _fenceRect;

    id woodchuckAction;
    id woodchuckAction2;
    id woodchuckAction3;
}



+(CCScene *) scene;

@end
