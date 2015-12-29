//
//  ProfileViewController.h
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* photos;
    NSArray* posts;
    IBOutlet UITableView* tableView;
}

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *posts;
- (IBAction)followBtn:(id)sender;
- (IBAction)followingBtn:(id)sender;
- (IBAction)optinosBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
- (IBAction)picsBtn:(id)sender;
- (IBAction)sortPicBtn:(id)sender;
- (IBAction)locationBtn:(id)sender;
- (IBAction)profilePicBtn:(id)sender;


@end