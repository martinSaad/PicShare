//
//  ProfileViewController.m
//  PicShare
//
//  Created by Martin Saad on 29/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "ProfileViewController.h"
#import "Model.h"
#import "Post.h"


@interface ProfileViewController ()
- (void)configureView;

@end


@implementation ProfileViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    //set the user name.
    self.userName.text = [[Model instance] getCurrentUser];
    
    //set the profile pic in a circle.
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    
    photos = [[NSMutableArray alloc] init];
    // __block NSArray* arr = [[NSArray alloc]init];
    // Do any additional setup after loading the view.
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        photos = [[Model instance]getPFobjects:currentUser];
        
        [[Model instance]getPhotosFromPFobjectArray:photos block:^(NSArray *arr) {
            posts = arr;
            [self.tableView reloadData];
        }];
        
    } else {
        // show the signup or login screen
    }
}
- (void)configureView
{
    // Update the user interface for the detail item.
    self.newsArray = [[NSMutableArray alloc] initWithObjects:@"hashTag",@"dubyGal", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // typically you need know which item the user has selected.
    // this method allows you to keep track of the selection
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsArray count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.newsArray objectAtIndex:row];
    
    return cell;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)optionBtn:(id)sender {
}
- (IBAction)followBtn:(id)sender {
}

- (IBAction)followingBtn:(id)sender {
}

- (IBAction)optinosBtn:(id)sender {
}


- (IBAction)picsBtn:(id)sender {
}

- (IBAction)sortPicBtn:(id)sender {
}

- (IBAction)locationBtn:(id)sender {
}




- (IBAction)tagBtn:(id)sender {
}
- (IBAction)options:(id)sender {
    
}
- (IBAction)likeBtn:(id)sender {
}

- (IBAction)picBtn:(id)sender {
}

@end



