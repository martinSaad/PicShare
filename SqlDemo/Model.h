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
-(void)getPhotos:(PFUser*)st block:(void(^)(NSArray*))block;
-(void)getLikesOfPhoto:(PFObject*)photo block:(void(^)(NSArray*))block;


//saveing type
//-(void)saveStudentImage:(Student*)st image:(UIImage*)image block:(void(^)(NSError*))block;
@end
















