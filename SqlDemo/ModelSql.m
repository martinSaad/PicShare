//
//  ModelSql.m
//  PicShare
//
//  Created by Martin Saad on 03/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import "ModelSql.h"
#import "Constants.h"

@implementation ModelSql

-(id)init{
    self = [super init];
    if (self) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        NSArray* paths = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        
        NSURL* directoryUrl = [paths objectAtIndex:0];
        
        NSURL* fileUrl = [directoryUrl URLByAppendingPathComponent:@"database.db"];
        
        NSString* filePath = [fileUrl path];
        
        const char* cFilePath = [filePath UTF8String];
        
        int res = sqlite3_open(cFilePath,&database);
        
        if(res != SQLITE_OK){
            NSLog(@"ERROR: fail to open db");
            database = nil;
        }
        
        char* errormsg;
        
        res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS USER (OBJECT_ID TEXT PRIMARY KEY, FIRST_NAME TEXT, LAST_NAME TEXT, USER_NAME TEXT, EMAIL TEXT, POSTS TEXT, FOLLOWING TEXT, WHO_FOLLOWS_ME TEXT)", NULL, NULL, &errormsg);
        
        if(res != SQLITE_OK){
            NSLog(@"ERROR: failed creating USERS table");
        }
    }
    return self;
}


-(void)signUp:(NSString*)objectId andFname:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email{
    
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@,%@,%@,%@,%@,%@,%@,%@) values (?,?,?,?,?,?,?,?);",@"USER",@"OBJECT_ID",@"FIRST_NAME",@"LAST_NAME",@"USER_NAME",@"EMAIL",@"POSTS",@"FOLLOWING",@"WHO_FOLLOWS_ME"];
    
    //posts,following and who_follows_me are 0
    NSString* posts = @"0";
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [objectId UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 2, [fName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 3, [lName UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 4, [username UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 5, [email UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 6, [posts UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 7, [posts UTF8String],-1,NULL);
        sqlite3_bind_text(statment, 8, [posts UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: SignUp SQL failed %s",sqlite3_errmsg(database));
}

-(NSString*)getPostNumber:(NSString*)userObjectId{
    sqlite3_stmt *statment;
    NSString* numberOfPosts;
    
    NSString* query = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=%@;",POSTS,USER_TABLE,OBJECT_ID,userObjectId];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        numberOfPosts = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
        
    }else{
        NSLog(@"ERROR: getPostNumber failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return numberOfPosts;
}

-(NSString*)getFollowingNumber:(NSString*)userObjectId{
    sqlite3_stmt *statment;
    NSString* numberOfFollowing;
    
    NSString* query = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=%@;",FOLLOWING,USER_TABLE,OBJECT_ID,userObjectId];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        numberOfFollowing = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
        
    }else{
        NSLog(@"ERROR: getFollowingNumber failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return numberOfFollowing;
}

-(NSString*)getWhoFollowsMeNumber:(NSString*)userObjectId{
    sqlite3_stmt *statment;
    NSString* numberOfWhoFollowsMe;
    
    NSString* query = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=%@;",WHO_FOLLOWS_ME,USER_TABLE,OBJECT_ID,userObjectId];
    
    if (sqlite3_prepare_v2(database,[query UTF8String], -1,&statment,nil) == SQLITE_OK){
        numberOfWhoFollowsMe = [NSString stringWithFormat:@"%s",sqlite3_column_text(statment,0)];
        
    }else{
        NSLog(@"ERROR: getWhoFollowsMeNumber failed %s",sqlite3_errmsg(database));
        return nil;
    }
    
    return numberOfWhoFollowsMe;
}


-(void)changePostNumberByOne:(NSString*)userObjectId change:(BOOL)change{
    NSString* postsNumber = [self getPostNumber:userObjectId];
    int posts = [postsNumber intValue];
    if (change){
        posts++;
    }
    else{
        posts--;
    }
    postsNumber = [NSString stringWithFormat:@"%d",posts];
    
    
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"UPDATE %@ SET %@=%@ WHERE %@=%@",USER_TABLE,POSTS,postsNumber,OBJECT_ID,userObjectId];
    
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [postsNumber UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addPostNumberByOne failed %s",sqlite3_errmsg(database));
}

-(void)changeFollowingNumberByOne:(NSString*)userObjectId change:(BOOL)change{
    NSString* followingNumber = [self getFollowingNumber:userObjectId];
    int following = [followingNumber intValue];
    if (change){
        following++;
    }
    else{
        following--;
    }
    followingNumber = [NSString stringWithFormat:@"%d",following];
    
    
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"UPDATE %@ SET %@=%@ WHERE %@=%@",USER_TABLE,FOLLOWING,followingNumber,OBJECT_ID,userObjectId];
    
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [followingNumber UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addFollowingNumberByOne failed %s",sqlite3_errmsg(database));
}


-(void)changeWhoFollowsMeNumberByOne:(NSString*)userObjectId change:(BOOL)change{
    NSString* whoFollowsMeNumber = [self getWhoFollowsMeNumber:userObjectId];
    int whoFollowsMe = [whoFollowsMeNumber intValue];
    if (change){
        whoFollowsMe++;
    }
    else{
        whoFollowsMe--;
    }
    whoFollowsMeNumber = [NSString stringWithFormat:@"%d",whoFollowsMe];
    
    
    sqlite3_stmt *statment;
    NSString* query = [NSString stringWithFormat:@"UPDATE %@ SET %@=%@ WHERE %@=%@",USER_TABLE,WHO_FOLLOWS_ME,whoFollowsMeNumber,OBJECT_ID,userObjectId];
    
    
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statment,nil) == SQLITE_OK){
        sqlite3_bind_text(statment, 1, [whoFollowsMeNumber UTF8String],-1,NULL);
        if(sqlite3_step(statment) == SQLITE_DONE){
            return;
        }
    }
    
    NSLog(@"ERROR: addWhoFollowsMeNumberByOne failed %s",sqlite3_errmsg(database));
}



@end
