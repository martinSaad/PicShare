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
    //set the user name.
    self.userName.text = [[Model instance] getCurrentUser];
    
    //set the profile pic in a circle.
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;

    
    
    PFUser* user = [PFUser currentUser];
    photosArr = [[Model instance] getPhotoObjectsSync:user];

    
    //sort the photoObjects by creation date
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    sortedPhotosObjects = [photosArr sortedArrayUsingDescriptors:sortDescriptors];
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
    
    //set profile pic
    [[Model instance]getProfilePicAsync:^(UIImage *image) {
        self.profilePic.image = image;
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
//    //go to HOME controller
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




- (IBAction)tagBtn:(id)sender {
}

- (IBAction)likeBtn:(id)sender {
}

- (IBAction)picBtn:(id)sender {
}

@end



