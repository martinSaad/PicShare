//
//  ModelSqlProtocol.h
//  PicShare
//
//  Created by Martin Saad on 03/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelSqlProtocol <NSObject>

-(void)signUp:(NSString*)objectId andFname:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email;

//change the values
//YES - add
//NO - subtract
-(void)changePostNumberByOne:(NSString*)userObjectId change:(BOOL)change;
-(void)changeFollowingNumberByOne:(NSString*)userObjectId change:(BOOL)change;
-(void)changeWhoFollowsMeNumberByOne:(NSString*)userObjectId change:(BOOL)change;


-(NSString*)getPostNumber:(NSString*)userObjectId;
-(NSString*)getFollowingNumber:(NSString*)userObjectId;
-(NSString*)getWhoFollowsMeNumber:(NSString*)userObjectId;

@end
