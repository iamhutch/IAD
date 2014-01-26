//
//  scores.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/23/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "scores.h"

@implementation scores

@synthesize _level, _objectID, _score, _scoresDictionary, _user, _date;

static scores *_instance = nil;

+(void)CreateInstance
{
    if (_instance == nil)
    {
        [[self alloc] init];
    }
}

+(scores*)GetInstance
{
    return _instance;
}

+(id)alloc
{
    _instance = [super alloc];
    return _instance;
}

-(id)init
{
    if (self = [super init])
    {
        // init code
    }
    return self;
}

-(NSDictionary*)getDictionary
{
    if (_scoresDictionary != nil)
    {
        return _scoresDictionary;
    }
    return NULL;
}


@end
