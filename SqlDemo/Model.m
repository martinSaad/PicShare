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

-(NSArray*)getFollowing{
    return [modelImpl getFollowingUsers];
}

-(NSArray*)getPhotoObjectsSync:(PFUser*)user{
    return [modelImpl getPhotoObjects:user];
}



//Block Asynch implementation
-(void)getFollowingUsersAsync:(void(^)(NSArray*))blockListener{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getFollowingUsers];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockListener(data);
        });
    } );
}

//Block Asynch implementation
-(void)getWhoFollowsMeAsync:(void(^)(NSArray*))blockListener{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getWhoFollowsMe];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockListener(data);
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
        UIImage* image = [modelImpl getPhotoFromObject:object];
        
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


-(void)signIn:(NSString*)username andPassword:(NSString*)password block:(void(^)(NSError*))block{
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl signIn:username andPassword:password];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}



-(PFGeoPoint*)getCurrentLocation{
    return [modelImpl getCurrentLocation];
}

-(void)uploadImageAsync:(UIImage*)image description:(NSString*)description hashtag:(NSString*)hashtag block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl uploadImage:image description:description hashtag:hashtag];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}

-(void)uploadProfileImageAsync:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl uploadProfileImage:image];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
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

-(NSString*)getPhotoDescription:(PFObject*)object{
    return [modelImpl getPhotoDescription:object];
}

-(NSString*)getPhotoHashTag:(PFObject*)object{
    return [modelImpl getPhotoHashTag:object];
}

@end










