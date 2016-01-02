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

//users
-(void)getFollowingUsersAsync:(PFUser*)user block:(void(^)(NSArray*))blockListener;
-(void)getWhoFollowsMeAsync:(PFUser*)user block:(void(^)(NSArray*))blockListener;
-(NSArray*)getFollowing:(PFUser*)user;
-(NSString*)getCurrentUser;
-(void)getUserNameFromUserObject:(PFUser*)user block:(void(^)(NSString*))block;
-(void)doIFollowThisUser:(PFUser*)user block:(void(^)(BOOL))block;
-(void)followUser:(PFUser*)user block:(void(^)(NSError*))block;
-(void)unFollowUser:(PFUser*)user block:(void(^)(NSError*))block;
-(void)getUserFromPhotoObject:(PFObject*)object block:(void(^)(PFUser*))block;



//login logut
-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone block:(void(^)(NSError*))block;
-(void)signIn:(NSString*)username andPassword:(NSString*)password block:(void(^)(BOOL))block;
-(void)logOut:(void(^)(NSError*))block;
-(BOOL)ifUserConnecter;


//location
-(PFGeoPoint*)getCurrentLocation;


//photo
-(NSArray*)getPhotoObjectsSync:(PFUser*)user;
-(void)getPhotoLikes:(PFObject*)object block:(void(^)(NSArray*))block;
-(NSString*)getPhotoDescription:(PFObject*)object;
-(NSString*)getPhotoHashTag:(PFObject*)object;
-(void)getUserNameFromObject:(PFObject*)object block:(void(^)(NSString*))block;
-(void)getProfilePicAsync:(PFUser*)user block:(void(^)(UIImage*))block;
-(void)getProfilePicAsync:(void(^)(UIImage*))block;
-(void)uploadImageAsync:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag imageName:(NSString*)imageName block:(void(^)(NSError*))block;
-(void)uploadProfileImageAsync:(UIImage*)image imageName:(NSString*)imageName block:(void(^)(NSError*))block;
-(void)getPhotoObjects:(PFUser*)user block:(void(^)(NSArray*))block;
-(void)getPhotoFromObject:(PFObject*)object block:(void(^)(UIImage*))block;

-(void)likeAPhoto:(PFObject*)photoObject block:(void(^)(NSError*))block;


@end
















