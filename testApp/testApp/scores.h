//
//  scores.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/23/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface scores : NSObject
{
    NSString *_objectID;
    NSNumber *_level;
    NSNumber *_score;
    NSString *_user;
    NSDictionary *_scoresDictionary;
}

@property (nonatomic, assign) NSString *_objectID;
@property (nonatomic, retain) NSNumber *_level;
@property (nonatomic, retain) NSNumber *_score;
@property (nonatomic, retain) NSString *_user;
@property (nonatomic, retain) NSDictionary *_scoresDictionary;

+(void)CreateInstance;

+(scores*)GetInstance;

-(NSDictionary*)getDictionary;

@end
