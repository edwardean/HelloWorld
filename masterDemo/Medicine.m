//
//  Medicine.m
//  fmdbtest
//
//  Created by Edward on 13-3-2.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "Medicine.h"

@implementation Medicine
@synthesize name,specifi,content;
@synthesize stringID;
- (id) initMedicineWithName:(NSString *)_name andSpecifi:(NSString *)_specifi andContent:(NSString *)_Content {
    if (self = [super init]) {
        name = [_name retain];
        if (_specifi== nil || [_specifi isEqualToString:@""]) {
            specifi =@"";
        } else
            specifi = [_specifi retain];
        
        if (_Content == nil || [_Content isEqualToString:@""]) {
            content = @"";
        } else
            content = [_Content retain];
    }
    return self;
}

+ (int)countAllMedicine {
    debugMethod();
    int count = 0;
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    if ([dataBase open]) {
    FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine"];
    while ([resultSet next]) {
        count ++;
    }
    }
    [dataBase close];
    return count;
}

+ (NSMutableArray *)findAllMedicineToArray {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    NSMutableArray *mutableArray = [NSMutableArray array];
    if ([dataBase open]) {

        FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine"];
        while ([resultSet next]) {
            NSString *NameStr = [resultSet stringForColumn:@"Name"];
            NSString *SpecifiStr = [resultSet stringForColumn:@"Specifi"];
            NSString *ContentStr = [resultSet stringForColumn:@"Content"];
            NSDictionary *recordDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                       NameStr,@"Name",
                                       SpecifiStr,@"Specifi",
                                       ContentStr,@"Content",nil];
            [mutableArray addObject:recordDic];
        }
    }
    [dataBase close];
    return mutableArray;
}


+ (int)countSomeMedicineByName:(NSString *)_name {
    debugMethod();
    int count = 0;
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    if ([dataBase open]) {
    FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine WHERE Name = ?",_name];
    while ([resultSet next]) {
        count ++;
    }
    }
    [dataBase close];
    return count;
}

+ (NSMutableArray *)findSomeMedicineByName:(NSString *)_name {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    NSMutableArray *mutableArry = [NSMutableArray array];
    if ([dataBase open]) {
        FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine WHERE Name = ?",_name];
        NSString *nameStr = [resultSet stringForColumn:@"Name"];
        NSString *specifiStr = [resultSet stringForColumn:@"Specifi"];
        NSString *contentStr = [resultSet stringForColumn:@"Content"];
        NSDictionary *recordDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   nameStr,@"Name",
                                   specifiStr,@"Specifi",
                                   contentStr,@"Content",nil];
        [mutableArry addObject:recordDic];
    }
    [dataBase close];
    return mutableArry;
    
}

+ (NSMutableArray *)findSomeMedicineBySpecifi:(NSString *)_specifi {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    NSMutableArray *mutableArry = [NSMutableArray array];
    if ([dataBase open]) {
        FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine WHERE Specifi = ?",_specifi];
        NSString *nameStr = [resultSet stringForColumn:@"Name"];
        NSString *specifiStr = [resultSet stringForColumn:@"Specifi"];
        NSString *contentStr = [resultSet stringForColumn:@"Content"];
        NSDictionary *recordDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   nameStr,@"Name",
                                   specifiStr,@"Specifi",
                                   contentStr,@"Content",nil];
        [mutableArry addObject:recordDic];
    }
    [dataBase close];
    return mutableArry;
}
+ (BOOL)createNewMedicine:(NSString *)_name andSpecifi:(NSString *)_specifi andContent:(NSString *)_content {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
            isOK = [dataBase executeUpdate:@"INSERT INTO Medicine (Name,Specifi,Content) VALUES (?,?,?)",
                         _name,
                         _specifi,
                         _content];
    }
    [dataBase close];
    return isOK;
}


/**
更新操作需要根据主键id来完成 
 **/
- (BOOL) findIDByMedicineName:(NSString *)_name andSpecifi:(NSString *)_specifi {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    if ([dataBase open]) {
    FMResultSet *resultSet = [dataBase executeQuery:@"SELECT * FROM Medicine"];
    while ([resultSet next]) {
        NSString *na = [resultSet stringForColumn:@"Name"];
        NSString *spe = [resultSet stringForColumn:@"Specifi"];
        debugLog(@"name:%@",na);
        debugLog(@"specifi:%@",spe);
        if ([_name isEqualToString:na] && [_specifi isEqualToString:spe]) {
            isOK = YES;
            self.stringID = [resultSet stringForColumn:@"id"];
        }
        
    }
    }
    [dataBase close];
    return isOK;
}
- (BOOL) updateMedicine:(NSString *)_name andSpecifi:(NSString *)_specifi andContent:(NSString *)_content {
    debugMethod();
    BOOL isOK = NO;
    FMDatabase *dataBase = [dataBaseManager createDataBase];
        if ([dataBase open]) {
            NSInteger idNumber = [self.stringID integerValue];
        isOK = [dataBase executeUpdate:@"UPDATE Medicine SET Name = ?, Specifi = ?, Content = ? WHERE id = ?",_name,_specifi,_content,idNumber];
        
        }
    [dataBase close];
    return isOK;
}
/**
删除某种药时，先根据规格和名称在数据库中检索出来具体是哪种药然后再进行删除
**/
+ (BOOL)deleteSomeMedicine:(NSString *)_name andSpecifi:(NSString *)_specifi {
    debugMethod();
    FMDatabase *dataBase = [dataBaseManager createDataBase];
    BOOL isOK = NO;
    
    if ([dataBase open]) {
        isOK = [dataBase executeUpdate:@"DELETE FROM Medicine WHERE Name = ? AND SPECIFI = ?",_name,_specifi];
    }
    [dataBase close];
    return isOK;
}
@end
