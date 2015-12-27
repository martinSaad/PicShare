//
//  PostsTableViewController.m
//  PicShare
//
//  Created by Martin Saad on 24/12/2015.
//  Copyright © 2015 menachi. All rights reserved.
//

#import "PostsTableViewController.h"
#import "PostsTableViewCell.h"
#import "Model.h"
#import "Post.h"
@interface PostsTableViewController ()

@end

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    posts = [[NSMutableArray alloc] init];
    __block NSArray* arr = [[NSArray alloc]init];
    
    [[Model instance] getFollowingUsersAsync:^(NSArray *followingUsersArray) {
        
        //create post for all proccess
        Post* post = [[Post alloc]init];
        
        followingUsers = followingUsersArray;
        
        for (PFUser* user in followingUsers){
           arr = [[Model instance] getPFobjects:user];
//            [[Model instance] getPhotos:user block:^(NSArray *pfobjectArr) {
//                arr = pfobjectArr;
//            }];
        }
        
        [[Model instance] getPhotosFromPFobjectArray:arr block:^(NSArray *photosArr) {
            photos = photosArr;
            [self.tableView reloadData];
        }];
        
        for (PFObject* photo in arr){
            [[Model instance] getLikesOfPhoto:photo block:^(NSArray *likesArr) {
                likes = likesArr;
                [self.tableView reloadData];
            }];
        }
        
    }];
    

    

    

    
    
//    [[Model instance] getFollowingUsersAsync:^(NSArray *followingUsersArray) {
//        followingUsers = followingUsersArray;
//        
//        //get photos of each user
//        for (PFUser* user in followingUsers){
//            [[Model instance] getPhotos:user block:^(NSArray * photosArray) {
//                arr = photosArray;
//                
//                //get photos
//                [Model instance] getPhotosFromPFobjectArray:arr block:^(NSArray *photosArr) {
//                    photos = photosArr;
//                }
//                
//                //get likes
//                
//                [self.tableView reloadData];
//            }];
//        }
//        //get likes of each photo
//        
//    }];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return photos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    int row = indexPath.row;
    cell.postImageView.image = [photos objectAtIndex:row];
    cell.likes.text = [NSString stringWithFormat:@"%d", [posts count]];
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
