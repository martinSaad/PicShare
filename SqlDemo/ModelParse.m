//
//  ModelParse.m
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "ModelParse.h"
#import <Parse/Parse.h>

@implementation ModelParse

-(id)init{
    self = [super init];
    if (self) {
        //[Parse setApplicationId:@"YiGE7RQ1aEUvCcOQT3nnoiGnhlvhPMKf9sZxf1pM"
          //            clientKey:@"TlM4WqYG6zYvepsJLNVPeRqSb3UcLda3QPXhWKpr"];

    }
    return self;
}

-(void)addStudent:(Student*)st{
    PFObject* obj = [PFObject objectWithClassName:@"Students"];
    obj[@"stId"] = st.stId;
    obj[@"fname"] = st.fname;
    obj[@"lname"] = st.lname;
    obj[@"phone"] = st.phone;
    obj[@"imageName"] = st.imageName;
    [obj save];
}

-(void)deleteStudent:(Student*)st{
    PFQuery* query = [PFQuery queryWithClassName:@"Students"];
    [query whereKey:@"stId" equalTo:st.stId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        [obj delete];
    }
}

-(Student*)getStudent:(NSString*)stId{
    Student* student = nil;
    PFQuery* query = [PFQuery queryWithClassName:@"Students"];
    [query whereKey:@"stId" equalTo:stId];
    NSArray* res = [query findObjects];
    if (res.count == 1) {
        PFObject* obj = [res objectAtIndex:0];
        student = [[Student alloc] init:obj[@"stId"] fname:obj[@"fname"] lname:obj[@"lname"] phone:obj[@"phone"] imageName:obj[@"imageName"]];
    }
    return student;
}

-(NSArray*)getStudents{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Students"];
    NSArray* res = [query findObjects];
    for (PFObject* obj in res) {
        Student* student = [[Student alloc] init:obj[@"stId"] fname:obj[@"fname"] lname:obj[@"lname"] phone:obj[@"phone"] imageName:obj[@"imageName"]];
        [array addObject:student];
    }
    return array;
}

-(void)saveImage:(UIImage*)image withName:(NSString*)imageName{
    NSData* imageData = UIImageJPEGRepresentation(image,0);
    
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
}

-(UIImage*)getImage:(NSString*)imageName{
    PFQuery* query = [PFQuery queryWithClassName:@"Images"];
    [query whereKey:@"imageName" equalTo:imageName];
    NSArray* res = [query findObjects];
    UIImage* image = nil;
    if (res.count == 1) {
        PFObject* imObj = [res objectAtIndex:0];
        PFFile* file = imObj[@"file"];
        NSData* data = [file getData];
        image = [UIImage imageWithData:data];
    }
    return image;
}













@end
