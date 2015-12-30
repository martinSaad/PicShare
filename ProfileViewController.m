//
//  ProfileViewController.m
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "ProfileViewController.h"
#import "Model.h"
#import "Post.h"
#import "PostsTableViewCell.h"
#import "CameraViewController.h"
#import "LoginViewController.h"


@interface ProfileViewController ()
- (void)configureView;

@end


@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    //set the user name.
//    self.userName.text = [[Model instance] getCurrentUser];
//    
//    //set the profile pic in a circle.
//    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
//    self.profilePic.clipsToBounds = YES;
//
//    
//    photos = [[NSMutableArray alloc] init];
//    // __block NSArray* arr = [[NSArray alloc]init];
//    // Do any additional setup after loading the view.
//    
//    PFUser *currentUser = [PFUser currentUser];
//    if (currentUser) {
//        photos = [[Model instance]getPFobjects:currentUser];
//        
//        [[Model instance]getPhotosFromPFobjectArray:photos block:^(NSArray *arr) {
//            posts = arr;
//            [tableView reloadData];
//        }];
//        
//    } else {
//        // show the signup or login screen
//    }
//    
//    //get profile pic
//    [[Model instance]getProfilePicAsync:^(UIImage *image) {
//        self.profilePic.image = image;
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [posts count];
}


// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellProfile" forIndexPath:indexPath];
    
    int row = indexPath.row;
    cell.postImageView.image = [posts objectAtIndex:row];
    
    return cell;

}




- (IBAction)followBtn:(id)sender {
}

- (IBAction)followingBtn:(id)sender {
}

- (IBAction)optinosBtn:(id)sender {
}


- (IBAction)picsBtn:(id)sender {
}

- (IBAction)sortPicBtn:(id)sender {
}

- (IBAction)locationBtn:(id)sender {
}

- (IBAction)profilePicBtn:(id)sender {
    //go to HOME controller
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController* cameraVC = [sb instantiateViewControllerWithIdentifier:@"CameraViewController"];
    
    cameraVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    cameraVC.isProfilePic = YES;
    [self showViewController:cameraVC sender:self];

}

- (IBAction)logoutBtn:(id)sender {
    [[Model instance]logOut:^(NSError *error) {
        //go to login controller
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController* loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
        
        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self showViewController:loginVC sender:self];
    }];
    

    
}




- (IBAction)tagBtn:(id)sender {
}

- (IBAction)likeBtn:(id)sender {
}

- (IBAction)picBtn:(id)sender {
}

@end



