//
//  SearchViewController.m
//  PicShare
//
//  Created by Martin Saad on 02/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import "SearchViewController.h"
#import "UsersTableViewCell.h"
#import "Model.h"

@implementation SearchViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [searchResults count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSearch" forIndexPath:indexPath];
    
    int row = indexPath.row;
    
    [[Model instance]getUserNameFromUserObject:[searchResults objectAtIndex:row] block:^(NSString *name) {
        cell.username.text = name;
    }];
    
    [[Model instance] getProfilePicAsync:[searchResults objectAtIndex:row] block:^(UIImage *image) {
        cell.image.image = image;
    }];
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [[Model instance] getUserName:searchText block:^(NSArray *result) {
        searchResults = result;
    }];
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
