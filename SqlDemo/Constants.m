//
//  Constants.m
//  PicShare
//
//  Created by Martin Saad on 26/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const USER_TABLE = @"User";
NSString *const PHOTO_TABLE = @"Photo";
NSString *const FOLLOWERS_TABLE = @"Followers";
NSString *const TAG_TABLE = @"Tag";
NSString *const COMMENT_TABLE = @"Comment";

NSString *const OBJECT_ID = @"objectId";


//user
NSString *const FIRST_NAME = @"first_name";
NSString *const LAST_NAME = @"last_name";
NSString *const GENDER = @"gender";
NSString *const PHONE = @"phone";
NSString *const EMAIL = @"email";
NSString *const BIO = @"bio";
NSString *const PHOTOS = @"photos";

//comment
NSString *const COMMENT = @"comment";
NSString *const PHOTO = @"photo";
NSString *const USER = @"user";

//followers
NSString *const FOLLOWING = @"following";
NSString *const WHO_FOLLOWS_ME = @"who_follows_me";

//tag
NSString *const TAG_NAME = @"tag_name";

//photo
NSString *const PICTURE = @"picture";
NSString *const LOCATION = @"location";
NSString *const LIKES = @"likes";
NSString *const DESCRIPTION = @"description";
NSString *const HASHTAG = @"hashtag";

@end
