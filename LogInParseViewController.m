//
//  LogInParseViewController.m
//  PicShare
//
//  Created by Martin Saad on 28/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "LogInParseViewController.h"

@implementation LogInParseViewController

-(void)viewDidLoad{
    self.fields = (PFLogInFieldsUsernameAndPassword
                   | PFLogInFieldsLogInButton
                   | PFLogInFieldsSignUpButton
                   | PFLogInFieldsPasswordForgotten
                   | PFLogInFieldsDismissButton
                   | PFLogInFieldsFacebook);
}
@end
