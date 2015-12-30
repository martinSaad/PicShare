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
    NSString* imageName;
}
- (IBAction)addPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *hashtag;
@property (weak, nonatomic) IBOutlet UITextField *disc;
@property BOOL isProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hashtagLabel;
- (IBAction)uploadBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtnLabel;




@end
