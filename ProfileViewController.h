//
//  ProfileViewController.h
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <parse/Parse.h>


@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* photos;
    IBOutlet UITableView* tableView;
    NSArray* photosArr;
    NSArray* sortedPhotosObjects;
    NSArray* likes;
    PFUser* user;
}

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *posts;
- (IBAction)followBtn:(id)sender;
- (IBAction)followingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
- (IBAction)picsBtn:(id)sender;
- (IBAction)sortPicBtn:(id)sender;
- (IBAction)locationBtn:(id)sender;
- (IBAction)profilePicBtn:(id)sender;
- (IBAction)logoutBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *postsNumber;
@property (weak, nonatomic) IBOutlet UILabel *followNumber;
@property (weak, nonatomic) IBOutlet UILabel *followingNumber;
@property (weak, nonatomic) IBOutlet UISwitch *followingOrNot;
- (IBAction)followingOrNotBtn:(id)sender;

@property PFUser* selectedUser;


@end