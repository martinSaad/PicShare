//
//  test.m
//  PicShare
//
//  Created by Martin Saad on 02/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import "test.h"
#import "UsersTableViewCell.h"
#import "Model.h"
@implementation test

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [searchResults count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //martinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"martin" forIndexPath:indexPath];
    
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"martin"];
    int row = indexPath.row;
    
    if (!cell){
        cell = [[UsersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"martin"];
    }
    
    [[Model instance]getUserNameFromUserObject:[searchResults objectAtIndex:row] block:^(NSString *name) {
        cell.username.text = @"Dddd";
    }];
    
    [[Model instance] getProfilePicAsync:[searchResults objectAtIndex:row] block:^(UIImage *image) {
        cell.image.image = image;
    }];
    
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    searchResults = [[Model instance] getUserName:searchText];
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
