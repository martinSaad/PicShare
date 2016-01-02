//
//  UsersTableViewController.m
//  PicShare
//
//  Created by Martin Saad on 31/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UsersTableViewCell.h"
#import "Model.h"
#import "ProfileViewController.h"
#import <parse/Parse.h>

@implementation UsersTableViewController


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellUsers" forIndexPath:indexPath];
    
    int row = indexPath.row;
    
    [[Model instance]getUserNameFromUserObject:[_users objectAtIndex:row] block:^(NSString *name) {
        cell.username.text = name;
    }];
    
    [[Model instance] getProfilePicAsync:[_users objectAtIndex:row] block:^(UIImage *image) {
        cell.image.image = image;
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController* profileVC = [sb instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    profileVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    PFUser* user = [_users objectAtIndex:row];
    profileVC.selectedUser = user;
    
    [self showViewController:profileVC sender:self];
    
}


@end
