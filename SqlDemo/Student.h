//
//  Student.h
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property NSString* stId;
@property NSString* fname;
@property NSString* lname;
@property NSString* phone;
@property NSString* imageName;

-(id)init:(NSString*)stId fname:(NSString*)fname lname:(NSString*)lname phone:(NSString*)phone imageName:(NSString*)imageName;
@end
