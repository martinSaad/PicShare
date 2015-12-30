//
//  PostsTableViewController.h
//  PicShare
//
//  Created by Martin Saad on 24/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsTableViewController : UITableViewController{
    NSArray* followingUsers;
    NSArray* likes;
    NSArray* descriptions;
    NSArray* hashtags;
    NSArray* sortedPhotosObjects;
    NSMutableArray* photoObjects;
    NSMutableArray* photosArr;
}

-(void)checkIfUserIsConnected;
@end
