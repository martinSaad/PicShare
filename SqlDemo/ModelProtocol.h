//
//  ModelProtocol.h
//  PicShare
//
//  Created by Martin Saad on 26/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>

-(void)saveImage:(UIImage*)image withName:(NSString*)imageName;

-(NSArray*)getPhotos:(PFUser*)user;
-(NSArray*)getPhotosFromPFobjectArray:(NSArray*)PFobjectArray;
-(NSArray*)getLikesOfPhoto:(PFObject*)photo;

-(NSArray*)getFollowingUsers;
-(NSArray*)getWhoFollowsMe;

-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone;
-(void)signIn:(NSString*)username andPassword:(NSString*)password;
-(void)getFacebookUserData;
-(void)saveUserDetails:(NSString*)name withEmail:(NSString*)email withGender:(NSString*)gender withPhotoUrl:(NSURL*)photoUrl;

//test
-(NSArray*)getPFobjects:(PFUser*)user;
@end
