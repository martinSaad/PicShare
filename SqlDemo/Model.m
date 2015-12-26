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

-(void)getPhoto:(PFUser*)user block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSArray* image = [modelImpl getPhotos:user];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}

-(void)getLikesOfPhoto:(PFObject*)photo block:(void(^)(NSArray*))block{
    dispatch_queue_t myQueue = dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        NSArray* likes = [modelImpl getLikesOfPhoto:photo];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(likes);
        });
    } );
}



//
//
//
//
//
//-(void)saveStudentImage:(Student*)st image:(UIImage*)image block:(void(^)(NSError*))block{
//    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
//    
//    dispatch_async(myQueue, ^{
//        [modelImpl saveImage:image withName:st.imageName];
//        
//        dispatch_queue_t mainQ = dispatch_get_main_queue();
//        dispatch_async(mainQ, ^{
//            block(nil);
//        });
//    } );
//}
@end










