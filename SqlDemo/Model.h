//
//  Model.h
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ModelProtocol.h"


@interface Model : NSObject{
    id<ModelProtocol> modelImpl;
}

+(Model*)instance;

-(void)getPhotoFromObject:(PFObject*)object block:(void(^)(UIImage*))block;
-(void)getPhotoLikes:(PFObject*)object block:(void(^)(NSArray*))block;
-(NSString*)getPhotoDescription:(PFObject*)object;
-(NSString*)getPhotoHashTag:(PFObject*)object;


-(void)getFollowingUsersAsync:(void(^)(NSArray*))blockListener;
-(void)getWhoFollowsMeAsync:(void(^)(NSArray*))blockListener;
-(void)getPhotoObjects:(PFUser*)user block:(void(^)(NSArray*))block;

-(void)getLikesOfPhoto:(PFObject*)photo block:(void(^)(NSArray*))block;

-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone block:(void(^)(NSError*))block;
-(void)signIn:(NSString*)username andPassword:(NSString*)password block:(void(^)(BOOL))block;
-(void)logOut:(void(^)(NSError*))block;

//saveing type
-(void)uploadImageAsync:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag block:(void(^)(NSError*))block;
-(void)uploadProfileImageAsync:(UIImage*)image block:(void(^)(NSError*))block;
-(PFGeoPoint*)getCurrentLocation;
-(NSString*)getCurrentUser;
-(void)getProfilePicAsync:(void(^)(UIImage*))block;
-(void)getLikesFromPFobjectArray:(NSArray*)PFobjectArray block:(void(^)(NSArray*))block;



-(NSArray*)getFollowing;
-(NSArray*)getPhotoObjectsSync:(PFUser*)user;
-(BOOL)ifUserConnecter;

@end
















