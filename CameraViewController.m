//
//  CameraViewController.m
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "CameraViewController.h"
#import "Model.h"
#import "PostsTableViewController.h"
#import "ProfileViewController.h"

@implementation CameraViewController

-(id)init {
    if (self = [super init])  {
        self.isProfilePic = NO;
    }
    return self;
}

-(void)viewDidLoad{
    if (self.isProfilePic == YES){
        self.hashtag.hidden = YES;
        self.hashtagLabel.hidden = YES;
        self.disc.hidden = YES;
        self.decriptionLabel.hidden = YES;
    }
    
    [self.uploadBtn setEnabled:NO];
}

- (IBAction)addPicture:(id)sender {
    
    actionSheet =[[UIActionSheet alloc]initWithTitle:@"UplaodImage" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library Image",@"Camera Image", nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            
        {
            
            imagePicker=[[UIImagePickerController alloc]init];
            
            imagePicker.delegate=self;
            
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        
    }
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        imagePicker=[[UIImagePickerController alloc]init];
        
        imagePicker.delegate=self;
        
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    else{
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error accessing Camera" message:@"Device does not support the camera" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [imageView setImage:image];
    
    [self.uploadBtn setEnabled:YES];

    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"upload"]){
        UIImage* image = [imageView image];
        [[Model instance]uploadImageAsync:image description:self.disc.text hashtag:self.hashtag.text block:^(NSError *error) {
            
        }];
    }
}

- (IBAction)upload:(id)sender {
    if (self.isProfilePic == NO){
        //upload image
        UIImage* image = [imageView image];
        [[Model instance]uploadImageAsync:image description:self.disc.text hashtag:self.hashtag.text block:^(NSError *error) {
            
        }];
        
        //go to HOME controller
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PostsTableViewController* postsVC = [sb instantiateViewControllerWithIdentifier:@"PostsViewController"];
        
        postsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self showViewController:postsVC sender:self];
    }
    
    //if the method is called from the profile pic (profile controller)
    else{
        //upload image
        UIImage* image = [imageView image];
        [[Model instance]uploadImageAsync:image description:self.disc.text hashtag:self.hashtag.text block:^(NSError *error) {
            
        }];
        
        //go to HOME controller
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PostsTableViewController* profileVC = [sb instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        
        profileVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self showViewController:profileVC sender:self];
    }
}
@end


