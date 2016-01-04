//
//  SearchViewController.m
//  PicShare
//
//  Created by Martin Saad on 02/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import "SearchUsersViewController.h"
#import "UsersTableViewCell.h"
#import "Model.h"

@implementation SearchUsersViewController

-(void)viewDidLoad{
        
    [[Model instance] getListOfUsers:^(NSArray *usersArr) {
        users = usersArr;
        [self.tableview reloadData];
    }];
    
    [[Model instance] getListOfUserNames:^(NSArray *usernamesArr) {
        usernames = usernamesArr;
        [self.tableview reloadData];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableview == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    else
        return [users count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSearch"];
    int row = indexPath.row;
    
    if (!cell){
        cell = [[UsersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellSearch"];
    }
    
    
    if (self.tableview == self.searchDisplayController.searchResultsTableView){
        cell.username.text = [searchResults objectAtIndex:row];
    }
    else{
        cell.username.text = [usernames objectAtIndex:row];
        [[Model instance] getProfilePicAsync:[users objectAtIndex:row] block:^(UIImage *image) {
            cell.image.image = image;
        }];
    }

    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //searchResults = [[Model instance] getUserName:searchText];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(SELF BEGINSWITH[c] %@)", searchText];
    searchResults = [usernames filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
@end
