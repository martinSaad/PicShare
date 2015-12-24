//
//  Student.m
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "Student.h"

@implementation Student

-(id)init:(NSString*)stId fname:(NSString*)fname lname:(NSString*)lname phone:(NSString*)phone imageName:(NSString*)imageName{
    self = [super init];
    if (self){
        _stId = stId;
        _fname = fname;
        _lname = lname;
        _phone = phone;
        _imageName = imageName;
    }
    return self;
}

@end
