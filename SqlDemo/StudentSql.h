//
//  StudentSql.h
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <sqlite3.h>


@interface StudentSql : NSObject

+(void)addStudent:(sqlite3*)database st:(Student*)st;
+(void)deleteStudent:(sqlite3*)database st:(Student*)st;
+(Student*)getStudent:(sqlite3*)database stId:(NSString*)stId;
+(NSArray*)getStudents:(sqlite3*)database;

@end
