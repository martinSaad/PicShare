//
//  SearchUsersViewController.h
//  PicShare
//
//  Created by Martin Saad on 02/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUsersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate >{
    NSArray* searchResults;
}

@end
