//
//  DBManager.m
//  testApp
//
//  Created by Lucy Hutcheson on 1/22/14.
//  Copyright (c) 2014 Lucy Hutcheson. All rights reserved.
//

#import "DBManager.h"
#import "scores.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"woodchuckrun.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "create table if not exists woodchuckrunscores (id integer primary key, user text, score integer, level integer, timestamp integer)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;

}

- (BOOL)saveData:(NSString*)user score:(NSNumber*)score level:(NSNumber*)level
{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSDate *dateY = [NSDate dateWithTimeIntervalSinceNow:-86400];
        NSNumber *timestamp = [NSNumber numberWithDouble:[dateY timeIntervalSince1970]];
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into woodchuckrunscores (user, score, level, timestamp) values (\"%@\", %@, %@, %@)", user, score, level, timestamp];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}


- (NSMutableArray*) findByColumn:(NSString*)columnName findByFilter:(NSString*)columnFilter showAll:(BOOL)showAll orderBy:(NSString*)orderBy
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        if (showAll)
        {
            querySQL = @"SELECT * FROM woodchuckrunscores";
        }
        else if (orderBy != nil)
        {
            querySQL = [NSString stringWithFormat:@"select * from woodchuckrunscores ORDER BY %@ DESC", orderBy];
        }
        else
        {
            // FORMAT SQL STATEMENT BASED ON ENTERED DATA
            querySQL = [NSString stringWithFormat:@"select %@ from woodchuckrunscores where %@=\"%@\"",columnName, columnName, columnFilter];
        }
        const char *query_stmt = [querySQL UTF8String];
        
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSInteger dataID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *dataUser = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *dataScore = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    NSNumber *dataScoreNum = [NSNumber numberWithInt:[dataScore intValue]];
                    NSString *dataLevel = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    NSNumber *dataLevelNum = [NSNumber numberWithInt:[dataLevel intValue]];
                    NSString *dataDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    NSNumber *dataDateNum = [NSNumber numberWithInt:[dataDate intValue]];

                    
                    scores *currentScore = [[scores alloc] init];
                    currentScore._objectID = dataID;
                    currentScore._user = dataUser;
                    currentScore._score = dataScoreNum;
                    currentScore._level = dataLevelNum;
                    currentScore._date = dataDateNum;
                    [resultArray addObject:currentScore];
                }
                return resultArray;
            }
            else
            {
                NSLog(@"Not found");
                return nil;
            }
            sqlite3_reset(statement);
        }
    }
    return nil;
}

@end
