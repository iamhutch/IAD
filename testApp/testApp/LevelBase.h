//
//  LevelBase.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/20/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface LevelBase : NSObject
{
    CGSize surface;
    CGSize winSize;
    NSString *woodchuckString;
    NSString *_barString;
    CGPoint _barCGP;
    CGPoint _barAnchorPoint;
    CCSprite *_background;
    CCSprite *_foreground;
    CCSprite *_bar;
    CCLabelTTF *_levelLabel;
    CCMenu *_pauseMenu;
    CCSprite *_woodchuckWalk;
    CCSprite *_woodchuckHit;
    CCSprite *_woodchuckSlide;
    CCSprite *_tractor;
    CCSprite *_wood;
    CCSprite *_wood2;
    CCSprite *_fence;
    BOOL gamePause;
    float _calculatedScore;
}

@property (readonly) NSString *woodchuckString;
@property (readonly) CGPoint _barCGP;
@property (readonly) NSString *_barString;
@property (readonly) CGPoint _barAnchorPoint;
@property (readonly) CCSprite *_bar;
@property (readonly) CCLabelTTF *_levelLabel;
@property (readonly) CCSprite *_background;
@property (readonly) CCSprite *_foreground;
@property (readonly) CCMenu *_pauseMenu;
@property (readonly) CCSprite *_woodchuckWalk;
@property (readonly) CCSprite *_woodchuckHit;
@property (readonly) CCSprite *_woodchuckSlide;
@property (readonly) CCSprite *_tractor;
@property (readonly) CCSprite *_wood;
@property (readonly) CCSprite *_wood2;
@property (readonly) CCSprite *_fence;

- (float)calculateScore:(float)timerValue;

@end
