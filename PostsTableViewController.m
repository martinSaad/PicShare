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
    photosArr = [[NSMutableArray alloc]init];
    
    //get users who i follow
    followingUsers = [[Model instance] getFollowing];
    
    
    //for each user, get an array of his photos objects (PFObject)
    photoObjects = [[NSMutableArray alloc]init];
    for (PFUser* user in followingUsers){
        NSArray* objects = [[Model instance] getPhotoObjectsSync:user];
        [photoObjects addObject:objects];
    }
    
    //save all photos regardless who is the user taht created it
    for (NSArray* arr in photoObjects){
        for (PFObject* obj in arr){
            [photosArr addObject:obj];
        }
    }
    
    //sort the photoObjects by creation date
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    sortedPhotosObjects = [photosArr sortedArrayUsingDescriptors:sortDescriptors];
    

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
    return sortedPhotosObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    int row = indexPath.row;
    PFObject* object = [sortedPhotosObjects objectAtIndex:row];
    
    __block UIImage* photo;
    [[Model instance] getPhotoFromObject:object block:^(UIImage * image) {
        photo = image;
        cell.postImageView.image = photo;
    }];
    
    [[Model instance]getPhotoLikes:object block:^(NSArray *array) {
        likes = array;
        int likesCount = [likes count];
        cell.likes.text = [NSString stringWithFormat:@"%d", likesCount];
    }];

    //TODO add likes description and hashtag
    
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
