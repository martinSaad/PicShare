//
//  Model.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "Model.h"
#import <sqlite3.h>
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

-(void)addStudent:(Student*)st{
    [modelImpl addStudent:st];
}
-(void)deleteStudent:(Student*)st{
    [modelImpl deleteStudent:st];
}
-(Student*)getStudent:(NSString*)stId{
    return [modelImpl getStudent:stId];
}
-(NSArray*)getStudents{
    return [modelImpl getStudents];
}


//Block Asynch implementation
-(void)getStudentsAsynch:(void(^)(NSArray*))blockListener{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        //long operation
        NSArray* data = [modelImpl getStudents];
        
        //end of long operation - update display in the main Q
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            blockListener(data);
        });
    } );
}

-(void)getStudentImage:(Student*)st block:(void(^)(UIImage*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        UIImage* image = [modelImpl getImage:st.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(image);
        });
    } );
}


-(void)saveStudentImage:(Student*)st image:(UIImage*)image block:(void(^)(NSError*))block{
    dispatch_queue_t myQueue =    dispatch_queue_create("myQueueName", NULL);
    
    dispatch_async(myQueue, ^{
        [modelImpl saveImage:image withName:st.imageName];
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            block(nil);
        });
    } );
}
@end










