//
//  StudentsTableViewController.m
//  SqlDemo
//
//  Created by Admin on 12/23/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "Model.h"
#import "StudentViewCell.h"
#import <Parse/Parse.h>

@interface StudentsTableViewController ()

@end

@implementation StudentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    students = [[NSArray alloc] init];
    [self.activityIndicator startAnimating];
    
//    Student* st = [[Student alloc] init:@"123466" fname:@"ashton" lname:@"B" phone:@"12341234" imageName:@"ashton.jpeg"];
//    
//    UIImage* image = [UIImage imageNamed:@"tmp.jpg"];
//    [[Model instance] saveStudentImage:st image:image block:^(NSError * error) {
//        [[Model instance] addStudent:st];
//    }];
    
    [[Model instance] getStudentsAsynch:^(NSArray * stArray) {
        students = stArray;
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentViewCell" forIndexPath:indexPath];
    
    Student* st = [students objectAtIndex:indexPath.row];
    cell.fnameView.text = st.fname;
    cell.lnameView.text = st.lname;
    cell.imageName = st.imageName;
    [cell.activityIndicator startAnimating];
    
    [[Model instance] getStudentImage:st block:^(UIImage *image) {
        if (image != nil && [cell.imageName isEqualToString:st.imageName]) {
            [cell.image setImage:image];
            [cell.activityIndicator stopAnimating];
            cell.activityIndicator.hidden = YES;
        }
    }];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
