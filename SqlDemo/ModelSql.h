//
//  ModelSql.h
//  SqlDemo
//
//  Created by Admin on 12/2/15.
//  Copyright (c) 2015 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Model.h"

@interface ModelSql : NSObject<ModelProtocol>{
    sqlite3* database;
}



@end
