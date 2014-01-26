//
//  DBManager.h
//  testApp
//
//  Created by Lucy Hutcheson on 1/22/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
    NSString *querySQL;
}

+ (DBManager*)getSharedInstance;
- (BOOL)createDB;
- (BOOL)saveData:(NSString*)user score:(NSNumber*)score level:(NSNumber*)level;

- (NSMutableArray*) findByColumn:(NSString*)columnName findByFilter:(NSString*)columnFilter showAll:(BOOL)showAll orderBy:(NSString*)orderBy;


@end
