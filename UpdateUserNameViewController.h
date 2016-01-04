//
//  UpdateUserNameViewController.h
//  PicShare
//
//  Created by Martin Saad on 03/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateUserNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
- (IBAction)updateBtn:(id)sender;

@end
