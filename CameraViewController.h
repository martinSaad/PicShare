//
//  CameraViewController.h
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    
    
    UIImagePickerController* imagePicker;
    UIActionSheet* actionSheet;
    
    IBOutlet UIImageView *imageView;

}
- (IBAction)addPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *hashtag;
@property (weak, nonatomic) IBOutlet UITextField *disc;




@end
