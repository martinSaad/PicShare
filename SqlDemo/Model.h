//
//  Model.h
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <UIKit/UIKit.h>

@protocol ModelProtocol <NSObject>

-(void)addStudent:(Student*)st;
-(void)deleteStudent:(Student*)st;
-(Student*)getStudent:(NSString*)stId;
-(NSArray*)getStudents;
-(void)saveImage:(UIImage*)image withName:(NSString*)imageName;
-(UIImage*)getImage:(NSString*)imageName;

@end


@protocol GetStudentsListener <NSObject>

-(void)done:(NSArray*)data;

@end


@interface Model : NSObject{
    id<ModelProtocol> modelImpl;
}

+(Model*)instance;

-(void)addStudent:(Student*)st;

-(void)getStudentsAsynch:(void(^)(NSArray*))blockListener;
-(void)getStudentImage:(Student*)st block:(void(^)(UIImage*))block;
-(void)saveStudentImage:(Student*)st image:(UIImage*)image block:(void(^)(NSError*))block;
@end
















