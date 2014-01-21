//
//  LevelOne.h
//  testApp
//
//  Created by Lucy Hutcheson on 12/1/13.
//  Copyright (c) 2013 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "AppDelegate.h"


@interface LevelOne : CCLayer 
{
    CGSize surface;
    CGSize winSize;
    CCSprite *background;
    CCSprite *foreground;
    CCSprite *bar;
    CCSprite *wood;
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
}



+(CCScene *) scene;

@end
