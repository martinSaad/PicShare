//
//  ProfileViewController.m
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "ProfileViewController.h"
#import "Model.h"
#import "PostsTableViewCell.h"
#import "CameraViewController.h"
#import "LoginViewController.h"
#import "UsersTableViewController.h"


@interface ProfileViewController ()


@end


@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //set the profile pic in a circle.
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    
    //showing my profile
    if (self.selectedUser == nil){
        
        //set profile pic
        [[Model instance] getProfilePicAsync:^(UIImage *pic) {
            self.profilePic.image = pic;
        }];
        
        //dismisse followingOrNot
        self.followingOrNot.hidden = YES;
        
        //set the user name.
        [self.uernameLabel setTitle:[[Model instance] getCurrentUser] forState:UIControlStateNormal];
        user = [PFUser currentUser];
        
        photosArr = [[Model instance] getPhotoObjectsSync:user];
        
        
        //sort the photoObjects by creation date
        NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
        sortedPhotosObjects = [photosArr sortedArrayUsingDescriptors:sortDescriptors];
        
        //setting number of posts,following,follwers
        self.postsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)[sortedPhotosObjects count]];
        
        [[Model instance] getFollowingUsersAsync:user block:^(NSArray *following) {
            self.followingNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)[following count]];
            
        }];
        
        [[Model instance] getWhoFollowsMeAsync:user block:^(NSArray *whoFollowingMe) {
            self.followingNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)[whoFollowingMe count]];
        }];
    }
    
    //else there is a user selected - shot users details
    else{
        [[Model instance] doIFollowThisUser:self.selectedUser block:^(BOOL result) {
            if (result)
                [self.followingOrNot setOn:YES];
            else
                [self.followingOrNot setOn:NO];
        }];
        
        //set profile pic
        [[Model instance] getProfilePicAsync:self.selectedUser block:^(UIImage *pic) {
            self.profilePic.image = pic;
        }];
        
        //set username
        [[Model instance]getUserNameFromUserObject:self.selectedUser block:^(NSString *name) {
            [self.uernameLabel setTitle:name forState:UIControlStateNormal];
        }];
        
        photosArr = [[Model instance] getPhotoObjectsSync:self.selectedUser];
        
        
        //sort the photoObjects by creation date
        NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
        sortedPhotosObjects = [photosArr sortedArrayUsingDescriptors:sortDescriptors];
        
        //setting number of posts,following,follwers
        self.postsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)[sortedPhotosObjects count]];
        
        [[Model instance] getFollowingUsersAsync:self.selectedUser block:^(NSArray *following) {
            self.followNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)[following count]];
        }];
        
        [[Model instance] getWhoFollowsMeAsync:self.selectedUser block:^(NSArray *whoFollowingMe) {
            self.followingNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)[whoFollowingMe count]];
        }];
    }
    

}

//if this controller is poped from camera
//meaning the user try to change his profile pic
//reload profile pic
-(void)viewDidAppear:(BOOL)animated{
    [[Model instance] getProfilePicAsync:^(UIImage *pic) {
        self.profilePic.image = pic;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sortedPhotosObjects count];
}


// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellProfile" forIndexPath:indexPath];
    
    int row = indexPath.row;
    PFObject* object = [sortedPhotosObjects objectAtIndex:row];

    //set image
    [[Model instance] getPhotoFromObject:object block:^(UIImage * image) {
        cell.postImageView.image = image;
    }];
    
    //set likes
    [[Model instance]getPhotoLikes:object block:^(NSArray *array) {
        likes = array;
        cell.likes.text = [NSString stringWithFormat:@"%d", [likes count]];
    }];
    
    //set title
    cell.descri.text = [[Model instance] getPhotoDescription:object];
    
    //set hashtag
    cell.hashtag.text = [[Model instance] getPhotoHashTag:object];
    
    return cell;

}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"followUsers"]) {
//        UsersTableViewController* usersVC = segue.destinationViewController;
//        [[Model instance]getFollowingUsersAsync:^(NSArray *followingUsers) {
//            usersVC.users = followingUsers;
//        }];
//    }
//}

- (IBAction)followBtn:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UsersTableViewController* usersVC = [sb instantiateViewControllerWithIdentifier:@"usersTableViewController"];
    
    usersVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [[Model instance]getFollowingUsersAsync:user block:^(NSArray *followingUsers) {
        usersVC.users = followingUsers;
        [self showViewController:usersVC sender:self];
    }];
    
}

- (IBAction)followingBtn:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UsersTableViewController* usersVC = [sb instantiateViewControllerWithIdentifier:@"usersTableViewController"];
    
    usersVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [[Model instance] getWhoFollowsMeAsync:user block:^(NSArray *whoFollowsMe) {
        usersVC.users = whoFollowsMe;
        [self showViewController:usersVC sender:self];
    }];
}



- (IBAction)picsBtn:(id)sender {
}

- (IBAction)sortPicBtn:(id)sender {
}

- (IBAction)locationBtn:(id)sender {
}

- (IBAction)profilePicBtn:(id)sender {
//    //go to camera controller
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController* cameraVC = [sb instantiateViewControllerWithIdentifier:@"CameraViewController"];
    
    cameraVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    cameraVC.isProfilePic = YES;
    [self showViewController:cameraVC sender:self];

    
}

- (IBAction)logoutBtn:(id)sender {
    [[Model instance]logOut:^(NSError *error) {
        //go to login controller
        [self performSegueWithIdentifier:@"profileToLogin" sender:self];
    }];
    

    
}

- (IBAction)followingOrNotBtn:(id)sender {
    //if press to unfollow
    if (![self.followingOrNot isOn]){
        [[Model instance] unFollowUser:self.selectedUser block:^(NSError *error) {
            [self.followingOrNot setOn:NO];
            
            //update following,followers
            [[Model instance] getFollowingUsersAsync:self.selectedUser block:^(NSArray *following) {
                self.followNumber.text = [NSString stringWithFormat:@"%d",[following count]];
            }];
            
            [[Model instance] getWhoFollowsMeAsync:self.selectedUser block:^(NSArray *whoFollowingMe) {
                self.followingNumber.text = [NSString stringWithFormat:@"%d",[whoFollowingMe count]];
            }];
        }];
    }
    else{ //if press to follow
        [[Model instance] followUser:self.selectedUser block:^(NSError *error) {
            [self.followingOrNot setOn:YES];
            
            //update following,followers
            [[Model instance] getFollowingUsersAsync:self.selectedUser block:^(NSArray *following) {
                self.followNumber.text = [NSString stringWithFormat:@"%d",[following count]];
            }];
            
            [[Model instance] getWhoFollowsMeAsync:self.selectedUser block:^(NSArray *whoFollowingMe) {
                self.followingNumber.text = [NSString stringWithFormat:@"%d",[whoFollowingMe count]];
            }];
        }];
    }
}
- (IBAction)username:(id)sender {
}

@end



