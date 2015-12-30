//
//  ModelProtocol.h
//  PicShare
//
//  Created by Martin Saad on 26/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>



//-(NSArray*)getPhotos:(PFUser*)user;
-(UIImage*)getPhotoFromObject:(PFObject*)object;
-(NSArray*)getPhotoLikes:(PFObject*)object;

-(NSArray*)getFollowingUsers;
-(NSArray*)getWhoFollowsMe;

-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone;
-(BOOL)signIn:(NSString*)username andPassword:(NSString*)password;
-(void)logOut;
-(void)getFacebookUserData;
-(void)saveUserDetails:(NSString*)name withEmail:(NSString*)email withGender:(NSString*)gender withPhotoUrl:(NSURL*)photoUrl;
-(PFGeoPoint*)getCurrentLocation;
-(void)uploadImage:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag;
-(void)uploadProfileImage:(UIImage*)image;
-(UIImage*)getProfilePic;

-(NSArray*)getPhotoObjects:(PFUser*)user;
-(NSString*)getCurrentUser;


-(NSString*)getPhotoDescription:(PFObject*)object;
-(NSString*)getPhotoHashTag:(PFObject*)object;



-(NSArray*)getFollowing;
-(BOOL)ifUserConnecter;

@end


