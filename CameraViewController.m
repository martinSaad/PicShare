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
#import <AssetsLibrary/AssetsLibrary.h>

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
    
    [self.uploadBtnLabel setEnabled:NO];
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
    
    [self.uploadBtnLabel setEnabled:YES];
    
    //get image name
    // get the ref url
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        imageName = [imageRep filename];
    };
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];

    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)uploadBtn:(id)sender {
    UIImage* image = [imageView image];
    
    if(!self.isProfilePic){
        [[Model instance] uploadImageAsync:image description:self.disc.text hashtag:self.hashtag.text imageName:imageName block:^(NSError *error) {
            [self performSegueWithIdentifier:@"uploadPhotoToFeed" sender:self];
        }];
    }
    else{
        [[Model instance]uploadProfileImageAsync:image imageName:imageName block:^(NSError *error) {
            [self performSegueWithIdentifier:@"uploadProfilePic" sender:self];
        }];
    }
}
@end


