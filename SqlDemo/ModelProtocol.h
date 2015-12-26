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
-(NSArray*)getLikesOfPhoto:(PFObject*)photo;

-(NSArray*)getFollowingUsers;
-(NSArray*)getWhoFollowsMe;

-(void)getFacebookUserData;
-(void)saveUserDetails:(NSString*)name withEmail:(NSString*)email withGender:(NSString*)gender withPhotoUrl:(NSURL*)photoUrl;

@end
