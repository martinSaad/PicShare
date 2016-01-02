//
//  SearchTableView.m
//  PicShare
//
//  Created by Martin Saad on 02/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import "SearchTableView.h"
#import "Model.h"
#import "UsersTableViewCell.h"
#import "SearchCell.h"

@implementation SearchTableView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [[Model instance] getListOfUserNames:^(NSArray *usernamesArr) {
        usernames = usernamesArr;
    }];
    
    [[Model instance] getListOfUsers:^(NSArray *usersArr) {
        users = usersArr;
    }];
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


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellSearch" forIndexPath:indexPath];

    int row = indexPath.row;    
    
    [[Model instance]getUserNameFromUserObject:[searchResults objectAtIndex:row] block:^(NSString *name) {
        cell.username.text = name;
    }];
    
    [[Model instance] getProfilePicAsync:[searchResults objectAtIndex:row] block:^(UIImage *image) {
        cell.image.image = image;
    }];
    
    return cell;
}


@end
