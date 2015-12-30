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
    // Do any additional setup after loading the view.
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    PFUser* user = [PFUser currentUser];
//    //if user is arleady logged in - skip login screen
//    if (user){
//        [self performSegueWithIdentifier:@"loginSeg" sender:self];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (IBAction)loginBtn:(id)sender {
    
    [[Model instance]signIn:self.userName.text andPassword:self.password.text block:^(BOOL success) {
        //if login successful
        if (success){
            UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainTabBarController* mainTBVC = [sb instantiateViewControllerWithIdentifier:@"mainTabBarController"];
            
            mainTBVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self showViewController:mainTBVC sender:self];
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
@end
