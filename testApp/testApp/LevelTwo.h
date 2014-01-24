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
#import <Parse/Parse.h>
#import "LevelBase.h"


@interface LevelTwo : CCLayer
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
    CGRect _woodRect2;
    CGRect _tractorRect;
    CCAction *tractorAction;
    bool gamePause;
    int _woodCount;
    int _gameLevel;
    CCSprite *woodchuckWalk;
    CCSprite *woodchuckHit;
    float _score;
    NSTimer *_scoreTimer;
    CCLabelTTF *timerLabel;
    int timer;
    NSString *username;
    LevelBase *baseLevel;
    int saveScoreOnce;

}



+(CCScene *) scene;

@end
