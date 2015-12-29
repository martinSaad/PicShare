//
//  CameraViewController.m
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "CameraViewController.h"
#import "Model.h"

@implementation CameraViewController



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

@end


