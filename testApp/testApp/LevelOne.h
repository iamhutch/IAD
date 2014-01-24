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
#import <Parse/Parse.h>
#import "LevelBase.h"


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
