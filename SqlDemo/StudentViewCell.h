//
//  StudentViewCell.h
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fnameView;
@property (weak, nonatomic) IBOutlet UILabel *lnameView;
@property NSString* imageName;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
