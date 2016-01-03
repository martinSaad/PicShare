//
//  ModelProtocol.h
//  PicShare
//
//  Created by Martin Saad on 26/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ModelProtocol <NSObject>

//users
-(NSArray*)getFollowingUsers:(PFUser*)user;
-(NSArray*)getWhoFollowsMe:(PFUser*)user;
-(NSString*)getCurrentUser;
-(NSString*)getUserNameFromUserObject:(PFUser*)user;
-(BOOL)doIFollowThisUser:(PFUser*)user;
-(void)followUser:(PFUser*)user;
-(void)unFollowUser:(PFUser*)user;
-(PFUser*)getUserFromPhotoObject:(PFObject*)object;
-(NSArray*)getListOfUserNames;
-(NSArray*)getListOfUsers;
-(NSArray*)getUserName:(NSString*)prefix;

//login logout
-(NSString*)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email;
-(BOOL)signIn:(NSString*)username andPassword:(NSString*)password;
-(void)logOut;
-(BOOL)ifUserConnecter;


//facebook
-(void)getFacebookUserData;
-(UIImage*)saveUserDetails:(NSString*)fname lastName:(NSString*)lname withEmail:(NSString*)email withPhotoUrl:(NSURL*)photoUrl;
-(void)facebookLogin;


//location
-(PFGeoPoint*)getCurrentLocation;


//photo
-(UIImage*)getPhotoFromObject:(PFObject*)object;
-(NSArray*)getPhotoLikes:(PFObject*)object;
-(NSString*)getPhotoDescription:(PFObject*)object;
-(NSString*)getPhotoHashTag:(PFObject*)object;
-(NSString*)getUserNameFromObject:(PFObject*)object;
-(UIImage*)getProfilePic:(PFUser*)user;
-(UIImage*)getProfilePic;
-(void)uploadImage:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag;
-(void)uploadProfileImage:(UIImage*)image;
-(NSArray*)getPhotoObjects:(PFUser*)user;
-(void)likeAPhoto:(PFObject*)photoObject;

@end


