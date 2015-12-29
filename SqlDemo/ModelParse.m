//
//  ModelParse.m
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "ModelParse.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Constants.h"

@implementation ModelParse

-(id)init{
    self = [super init];
    if (self) {
        //[Parse setApplicationId:@"YiGE7RQ1aEUvCcOQT3nnoiGnhlvhPMKf9sZxf1pM"
          //            clientKey:@"TlM4WqYG6zYvepsJLNVPeRqSb3UcLda3QPXhWKpr"];

    }
    return self;
}

-(NSArray*)getFollowingUsers{
    PFUser* currentUser = [PFUser currentUser];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:currentUser];
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        PFUser* user = [obj objectForKey:FOLLOWING];
        [array addObject:user];
    }
    return array;
}


-(NSArray*)getWhoFollowsMe{
    PFUser* currentUser = [PFUser currentUser];
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:currentUser];
    NSArray* res = [query findObjects];
    
    for (PFObject* obj in res) {
        PFUser* user = [obj objectForKey:WHO_FOLLOWS_ME];
        [array addObject:user];
    }
    return array;
}

-(NSArray*)getPhotos:(PFUser*)user{
    PFQuery* query = [PFQuery queryWithClassName:PHOTO_TABLE];
    [query whereKey:USER equalTo:user];
    NSArray* res = [query findObjects];
    
    return res;
}

//test
-(NSArray*)getPFobjects:(PFUser*)user{
    PFQuery* query = [PFQuery queryWithClassName:PHOTO_TABLE];
    [query whereKey:USER equalTo:user];
    NSArray* res = [query findObjects];
    
    return res;
}

-(NSArray*)getPhotosFromPFobjectArray:(NSArray*)PFobjectArray{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(PFObject* obj in PFobjectArray){
        PFFile* file = obj[PICTURE];
        NSData* data = [file getData];
        UIImage* photo = [UIImage imageWithData:data];
        [array addObject:photo];
    }
    return array;
}

-(NSArray*)getLikesOfPhoto:(PFObject *)photo{
    PFQuery* query = [PFQuery queryWithClassName:PHOTO_TABLE];
    [query whereKey:OBJECT_ID equalTo:photo];
    NSArray* res = [query findObjects];
    
    NSMutableArray* likes = [[NSMutableArray alloc]init];
    for (PFUser* user in res){
        [likes addObject:user[FIRST_NAME]];
    }
    
    
    return likes;
}





-(void)saveImage:(UIImage*)image withName:(NSString*)imageName{
    NSData* imageData = UIImageJPEGRepresentation(image,0);
    
    PFFile* file = [PFFile fileWithName:imageName data:imageData];
    PFObject* fileobj = [PFObject objectWithClassName:@"Images"];
    fileobj[@"imageName"] = imageName;
    fileobj[@"file"] = file;
    [fileobj save];
}

-(void)saveUserDetails:(NSString*)name withEmail:(NSString*)email withGender:(NSString*)gender withPhotoUrl:(NSURL*)photoUrl{
    
    PFUser *currentUser = [PFUser currentUser];
    NSArray* names = [name componentsSeparatedByString:@" "];
    if (names.count == 2){
        currentUser[@"first_name"] = [names objectAtIndex:0];
        currentUser[@"last_name"] = [names objectAtIndex:1];
    }
    currentUser[@"email"] = email;
    currentUser[@"gender"] = gender;
}

- (void)getFacebookUserData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *email = userData[@"email"];
            NSString *gender = userData[@"gender"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            [self saveUserDetails:name withEmail:email withGender:gender withPhotoUrl:pictureURL];
        }
    }];
}


-(void)signUp:(NSString*)fName andLname:(NSString*)lName andUsername:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email andPhone:(NSString*)phone {
    
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    user[PHONE] = phone;
    user[FIRST_NAME] = fName;
    user[LAST_NAME] = lName;
    
    [user signUp];
    
}

-(void)signIn:(NSString*)username andPassword:(NSString*)password{
    [PFUser logInWithUsername:username password:password];
}

-(PFGeoPoint*)getCurrentLocation{
    __block PFGeoPoint* location = nil;
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint * _Nullable geoPoint, NSError * _Nullable error) {
        location = geoPoint;
    }];
    
    return location;
}

-(void)uploadImage:(UIImage *)image description:(NSString*)description hashtag:(NSString*)hashtag{
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:description data:imageData];
    
    PFObject *userPhoto = [PFObject objectWithClassName:PHOTO_TABLE];
    userPhoto[USER] = [PFUser currentUser];
    userPhoto[PICTURE] = imageFile;
    userPhoto[DESCRIPTION] = description;
    userPhoto[HASHTAG] = hashtag;
    
//    PFGeoPoint* currentLocation = [self getCurrentLocation];
//    userPhoto[LOCATION] = currentLocation;

    
    [userPhoto save];
}

-(NSString*)getCurrentUser{
    PFUser* user = [PFUser currentUser];
    NSString* firstName = user[FIRST_NAME];
    NSString* lastName = user[LAST_NAME];
    NSString* fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return fullName;
    
}

@end
