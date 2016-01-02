//
//  Model.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "Model.h"
#import "ModelSql.h"
#import "ModelParse.h"
#import "Constants.h"

@implementation Model

static Model* instance = nil;

+(Model*)instance{
    @synchronized(self){
        if (instance == nil) {
            instance = [[Model alloc] init];
        }
    }
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        //modelImpl = [[ModelSql alloc] init];
        modelImpl = [[ModelParse alloc] init];
    }
    return self;
}



-(NSArray*)getPhotoObjectsSync:(PFUser*)user{
    return [modelImpl getPhotoObjects:user];
}

-(NSArray*)getFollowing:(PFUser*)user{
    return [modelImpl getFollowingUsers:user];
}

//Block Asynch implementation
-(void)getFollowingUsersAsync:(PFUser*)user block:(void(^)(NSArray*))blockListener{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getFollowingUsers:user];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockListener(data);
        });
    } );
}

//Block Asynch implementation
-(void)getWhoFollowsMeAsync:(PFUser*)user block:(void(^)(NSArray*))blockListener{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getWhoFollowsMe:user];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockListener(data);
        });
    } );
}

-(void)doIFollowThisUser:(PFUser*)user block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        BOOL data = [modelImpl doIFollowThisUser:user];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(data);
        });
    } );
}

-(void)getPhotoObjects:(PFUser*)user block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSArray* image = [modelImpl getPhotoObjects:user];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}

-(void)getPhotoFromObject:(PFObject*)object block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //first try to get the image from local file
        UIImage* image = [self readingImageFromFile:object[DESCRIPTION]];
        
        //if failed to get image from file try to get it from parse
        if(image == nil){
            image = [modelImpl getPhotoFromObject:object];
            //one the image is loaded save it localy
            if(image != nil){
                [self savingImageToFile:image fileName:DESCRIPTION];
            }
        }
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}

-(void)getPhotoLikes:(PFObject*)object block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSArray* likes = [modelImpl getPhotoLikes:object];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(likes);
        });
    } );
}



-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone block:(void(^)(NSError*))block{
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);

    dispatch_async(myQueue, ^{
        [modelImpl signUp:fName andLname:lName andUsername:username andPassword:password andEmail:email andPhone:phone];

        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}


-(void)signIn:(NSString*)username andPassword:(NSString*)password block:(void(^)(BOOL))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        BOOL result = [modelImpl signIn:username andPassword:password];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(result);
        });
    } );
}

-(void)logOut:(void(^)(NSError*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl logOut];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(PFGeoPoint*)getCurrentLocation{
    return [modelImpl getCurrentLocation];
}

-(void)uploadImageAsync:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag imageName:(NSString*)imageName block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //save image to parse
        [modelImpl uploadImage:image description:description hashtag:hashtag];
        
        //save image localy
        [self savingImageToFile:image fileName:imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)uploadProfileImageAsync:(UIImage*)image imageName:(NSString*)imageName block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //save image to parse
        [modelImpl uploadProfileImage:image];
        
        //save image localy
        [self savingImageToFile:image fileName:imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)getUserNameFromObject:(PFObject*)object block:(void(^)(NSString*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSString* result = [modelImpl getUserNameFromObject:object];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(result);
        });
    } );
}

-(void)getUserNameFromUserObject:(PFUser*)user block:(void(^)(NSString*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSString* result = [modelImpl getUserNameFromUserObject:user];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(result);
        });
    } );
}

-(NSString*)getCurrentUser{
    return [modelImpl getCurrentUser];
}


-(void)getProfilePicAsync:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        UIImage* profilePic = [modelImpl getProfilePic];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(profilePic);
        });
    } );
}

-(void)getProfilePicAsync:(PFUser*)user block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        UIImage* profilePic = [modelImpl getProfilePic:user];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(profilePic);
        });
    } );
}

-(NSString*)getPhotoDescription:(PFObject*)object{
    return [modelImpl getPhotoDescription:object];
}

-(NSString*)getPhotoHashTag:(PFObject*)object{
    return [modelImpl getPhotoHashTag:object];
}

-(BOOL)ifUserConnecter{
    return [modelImpl ifUserConnecter];
}


// Working with local files

-(void)savingImageToFile:(UIImage*)image fileName:(NSString*)fileName{
    NSData *pngData = UIImagePNGRepresentation(image);
    [self saveToFile:pngData fileName:fileName];
}

-(UIImage*)readingImageFromFile:(NSString*)fileName{
    NSData* pngData = [self readFromFile:fileName];
    if (pngData == nil) return nil;
    return [UIImage imageWithData:pngData];
}


-(NSString*)getLocalFilePath:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    return filePath;
}

-(void)saveToFile:(NSData*)data fileName:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    [data writeToFile:filePath atomically:YES]; //Write the file
}

-(NSData*)readFromFile:(NSString*)fileName{
    NSString* filePath = [self getLocalFilePath:fileName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    return pngData;
}

@end










