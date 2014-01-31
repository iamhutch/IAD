//
//  LevelFour.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/30/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import <Parse/Parse.h>
#import "LevelBase.h"

@interface LevelFour : CCLayer
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
    CGRect _woodRect2;
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
