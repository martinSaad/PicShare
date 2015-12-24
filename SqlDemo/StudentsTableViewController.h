//
//  StudentsTableViewController.h
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentsTableViewController : UITableViewController{
    NSArray* students;
}


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
