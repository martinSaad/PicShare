//
//  ModelSql.h
//  PicShare
//
//  Created by Martin Saad on 03/01/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ModelSqlProtocol.h"

@interface ModelSql : NSObject<ModelSqlProtocol>{
    sqlite3* database;
}
@end
