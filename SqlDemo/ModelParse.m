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

-(NSArray*)getFollowingUsers:(PFUser*)user{
    
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:user];
    NSArray* res = [query findObjects];
    NSArray* following;
    if ([res count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res objectAtIndex:0];
        PFRelation *relation = [object relationForKey:FOLLOWING];
        PFQuery *queryRelation = [relation query];
        following = [queryRelation findObjects];
    }
    return following;
}


-(NSArray*)getWhoFollowsMe:(PFUser*)user{
    
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:user];
    NSArray* res = [query findObjects];
    NSArray* whoFollowsMe;
    if ([res count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res objectAtIndex:0];
        PFRelation *relation = [object relationForKey:WHO_FOLLOWS_ME];
        PFQuery *queryRelation = [relation query];
        whoFollowsMe = [queryRelation findObjects];
    }

    
    return whoFollowsMe;
}

-(void)followUser:(PFUser *)user{
    //add user to my FOLLOWING column
    PFUser* currentUser = [PFUser currentUser];
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:currentUser];
    NSArray* res = [query findObjects];
    if ([res count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res objectAtIndex:0];
        PFRelation *relation = [object relationForKey:FOLLOWING];
        [relation addObject:user];
        [object save];
    }
    
    //add me to the users WHO_FOLLOWS_ME column
    PFQuery* query2 = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query2 whereKey:USER equalTo:user];
    NSArray* res2 = [query2 findObjects];
    if ([res2 count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res2 objectAtIndex:0];
        PFRelation *relation = [object relationForKey:WHO_FOLLOWS_ME];
        [relation addObject:currentUser];
        [object save];
    }
}

-(void)unFollowUser:(PFUser *)user{
    PFUser* currentUser = [PFUser currentUser];
    
    //remove user from my FOLLOWING column
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:currentUser];
    NSArray* res = [query findObjects];
    if ([res count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res objectAtIndex:0];
        PFRelation *relation = [object relationForKey:FOLLOWING];
        [relation removeObject:user];
        [object save];
    }
    
    //remove me from the users WHO_FOLLOWS_ME column
    PFQuery* query2 = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query2 whereKey:USER equalTo:user];
    NSArray* res2 = [query2 findObjects];
    if ([res2 count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res2 objectAtIndex:0];
        PFRelation *relation = [object relationForKey:WHO_FOLLOWS_ME];
        [relation removeObject:currentUser];
        [object save];
    }

}

-(void)likeAPhoto:(PFObject *)photoObject{
    PFUser* currentUser = [PFUser currentUser];
    
    PFRelation *relation = [photoObject relationForKey:LIKES];
    PFQuery *queryRelation = [relation query];
    NSArray* likes = [queryRelation findObjects];
    
    //check if I'm in the likes users. if not - add me. if yes - remove me
    BOOL flag = NO;
    for (PFUser* user in likes){
        if ([user.objectId isEqualToString:currentUser.objectId]){
            flag = YES;
            break;
        }
    }
    if (flag == NO){
        [relation addObject:currentUser];
    }
    else{
        [relation removeObject:currentUser];
    }
    
    [photoObject save];
}

-(PFUser*)getUserFromPhotoObject:(PFObject *)object{
    PFUser* user = [object objectForKey:USER];
    [user fetchIfNeeded];
    return user;
}

-(BOOL)doIFollowThisUser:(PFUser*)user{
    NSArray* following;
    PFUser* currentUser = [PFUser currentUser];
    PFQuery* query = [PFQuery queryWithClassName:FOLLOWERS_TABLE];
    [query whereKey:USER equalTo:currentUser];
    NSArray* res = [query findObjects];
    if ([res count] == 1){
        //res is an array with only 1 result
        PFObject* object = [res objectAtIndex:0];
        PFRelation *relation = [object relationForKey:FOLLOWING];
        PFQuery *queryRelation = [relation query];
        following = [queryRelation findObjects];
        
        for (PFUser* userWhoIFollow in following){
            if ([userWhoIFollow.objectId isEqualToString:user.objectId])
                return YES;
        }
    }
    return NO;
}




-(NSArray*)getPhotoObjects:(PFUser*)user{
    PFQuery* query = [PFQuery queryWithClassName:PHOTO_TABLE];
    [query whereKey:USER equalTo:user];
    NSArray* res = [query findObjects];
    
    return res;
}

-(UIImage*)getPhotoFromObject:(PFObject*)object{
    PFFile* file = object[PICTURE];
    NSData* data = [file getData];
    UIImage* photo = [UIImage imageWithData:data];
    return photo;
}

-(NSArray*)getPhotoLikes:(PFObject*)object{
    PFRelation *relation = [object relationForKey:LIKES];
    PFQuery *queryRelation = [relation query];
    NSArray* likes = [queryRelation findObjects];
    return likes;
}

-(NSString*)getPhotoDescription:(PFObject*)object{
    return object[DESCRIPTION];
}

-(NSString*)getPhotoHashTag:(PFObject*)object{
    return object[HASHTAG];
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

-(BOOL)signIn:(NSString*)username andPassword:(NSString*)password{
    [PFUser logInWithUsername:username password:password];
    PFUser* user = [PFUser currentUser];
    if (user)
        return YES;
    
    return NO;
}

-(void)logOut{
    [PFUser logOut];
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
    //userPhoto[USER] = [PFUser currentUser];
    [userPhoto setObject:[PFUser currentUser] forKey:USER];
    userPhoto[PICTURE] = imageFile;
    userPhoto[DESCRIPTION] = description;
    userPhoto[HASHTAG] = hashtag;
    
//    PFGeoPoint* currentLocation = [self getCurrentLocation];
//    userPhoto[LOCATION] = currentLocation;

    
    [userPhoto save];
}

-(void)uploadProfileImage:(UIImage*)image{
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"profile" data:imageData];
    
    PFUser* currentUser = [PFUser currentUser];
    currentUser[PROFILE_PIC] = imageFile;
    [currentUser save];
}

-(NSString*)getCurrentUser{
    PFUser* user = [PFUser currentUser];
    NSString* firstName = user[FIRST_NAME];
    NSString* lastName = user[LAST_NAME];
    NSString* fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return fullName;
    
}

-(UIImage*)getProfilePic{
    PFUser* user = [PFUser currentUser];
    
    PFFile* file = user[PROFILE_PIC];
    NSData* data = [file getData];
    UIImage* photo = [UIImage imageWithData:data];
    return photo;
}

-(UIImage*)getProfilePic:(PFUser*)user{
    PFFile* file = user[PROFILE_PIC];
    NSData* data = [file getData];
    UIImage* photo = [UIImage imageWithData:data];
    return photo;
}

-(BOOL)ifUserConnecter{
    PFUser* user = [PFUser currentUser];
    if (user)
        return YES;
    
    return NO;
}

-(NSString*)getUserNameFromObject:(PFObject*)object{
    PFUser* user = [object objectForKey:USER];
    [user fetchIfNeeded];
    
    NSString* username = user.username;
    
    return username;
}

-(NSString*)getUserNameFromUserObject:(PFUser *)user{
    NSString* username = user.username;
    
    return username;
}

-(NSArray*)getListOfUserNames{
    PFQuery *query = [PFUser query];
    NSArray* users = [query findObjects];
    NSMutableArray* usernames = [[NSMutableArray alloc]init];
    for (PFUser* user in users)
        [usernames addObject:user.username];
    
    return usernames;
}

-(NSArray*)getListOfUsers{
    PFQuery *query = [PFUser query];
    NSArray* users = [query findObjects];
    return users;
}

-(NSArray*)getUserName:(NSString *)prefix{
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(username BEGINSWITH[cd] %@)", prefix];
    PFQuery *query = [PFUser query];
    query = [PFQuery queryWithClassName:USER_TABLE predicate:predicate];
    
    NSArray* users = [query findObjects];
    return  users;
}

@end
