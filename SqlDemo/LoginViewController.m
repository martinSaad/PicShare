//
//  LoginViewController.m
//  SqlDemo
//
//  Created by Martin Saad on 24/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import "Model.h"
#import "PostsTableViewController.h"
#import "MainTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtn:(id)sender {
    
    [[Model instance]signIn:self.userName.text andPassword:self.password.text block:^(BOOL success) {
        //if login successful
        if (success){
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops.."
                                                            message:@"Your login details is incorrect."
                                                           delegate:self
                                                  cancelButtonTitle:@"Try again"
                                                  otherButtonTitles:@"",nil];
            [alert show];
        }
    }];
    

}

- (IBAction)facebookLogin:(id)sender {
    [[Model instance] facebookLogin:^(NSError *error) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }];

}
@end
