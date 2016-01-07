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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)signUp:(id)sender {
    [[Model instance] signUp:self.firstName.text andLname:self.lastName.text andUsername:self.userName.text andPassword:self.password.text andEmail:self.email.text block:^(NSString * objectId) {
        [self performSegueWithIdentifier:@"signUpSecondSeg" sender:self];
    }];
}
@end
