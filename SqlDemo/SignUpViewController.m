//
//  SignUpViewController.m
//  SqlDemo
//
//  Created by Martin Saad on 24/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "SignUpViewController.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PostsTableViewController.h"
#import "Model.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"facebookLoginSeg"]){
//        [PFFacebookUtils logInInBackgroundWithReadPermissions:@[ @"public_profile", @"email", @"user_photos"]  block:^(PFUser *user, NSError *error) {
//            if (!user) {
//                NSLog(@"Uh oh. The user cancelled the Facebook login.");
//            } else if (user.isNew) {
//                NSLog(@"User signed up and logged in through Facebook!");
//            } else {
//                NSLog(@"User logged in through Facebook!");
//                //PostsTableViewController* postsVC = segue.destinationViewController;
//
//            }
//        }];
//    }
//    
//    else if([segue.identifier isEqualToString:@"signUpSecondSeg"]){
//        [[Model instance] signUp:self.firstName.text andLname:self.lastName.text andUsername:self.userName.text andPassword:self.password.text andEmail:self.userName.text andPhone:self.phone.text block:^(NSString * objectId) {
//            
//        }];
//    }
//}


- (IBAction)signUp:(id)sender {
    [[Model instance] signUp:self.firstName.text andLname:self.lastName.text andUsername:self.userName.text andPassword:self.password.text andEmail:self.userName.text andPhone:self.phone.text block:^(NSString * objectId) {
        [self performSegueWithIdentifier:@"signUpSecondSeg" sender:self];
    }];
}
@end
