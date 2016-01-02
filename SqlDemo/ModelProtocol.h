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

//login logout
-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone;
-(BOOL)signIn:(NSString*)username andPassword:(NSString*)password;
-(void)logOut;
-(BOOL)ifUserConnecter;


//facebook
-(void)getFacebookUserData;
-(void)saveUserDetails:(NSString*)name withEmail:(NSString*)email withGender:(NSString*)gender withPhotoUrl:(NSURL*)photoUrl;


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



@end


