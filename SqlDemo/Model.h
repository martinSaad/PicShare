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


-(void)getFollowingUsersAsync:(void(^)(NSArray*))blockListener;
-(void)getWhoFollowsMeAsync:(void(^)(NSArray*))blockListener;
-(void)getPhotos:(PFUser*)user block:(void(^)(NSArray*))block;
-(void)getPhotosFromPFobjectArray:(NSArray*)PFobjectArray block:(void(^)(NSArray*))block;
-(void)getLikesOfPhoto:(PFObject*)photo block:(void(^)(NSArray*))block;

-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone block:(void(^)(NSError*))block;
-(void)signIn:(NSString*)username andPassword:(NSString*)password block:(void(^)(NSError*))block;

-(NSArray*)getPFobjects:(PFUser*)user;

//saveing type
-(void)uploadImageAsync:(UIImage*)image block:(void(^)(NSError*))block;
-(PFGeoPoint*)getCurrentLocation;
@end
















