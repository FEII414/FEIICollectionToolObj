////
////  FEIDatabaseManager.m
////  dploffice
////
////  Created by fei li on 2018/4/20.
////  Copyright © 2018年 com. All rights reserved.
////
//
//#import "FEIDatabaseManager.h"
//#import "FMDB.h"
//
//static FMDatabase *_db;
//
//@interface FEIDatabaseManager()
//
//@end
//
//@implementation FEIDatabaseManager
//
//
//+ (void)creatDB{
//    
//    //获得Documents目录路径
//    NSString *doucmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
//    
//    //文件路径
//    NSString *filePath = [doucmentPath stringByAppendingPathComponent:@"mainDB.sqlite"];
//    NSLog(@"filePath--%@",filePath);
//    
//    if (_db == nil) {
//        _db = [FMDatabase databaseWithPath:filePath];
//    }
//    
//    if ([_db open]) {
//        
//        // 初始化数据表
//        NSString *personSql = @"CREATE TABLE IF NOT EXISTS 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number'VARCHAR(255)) ";
//        NSString *carSql = @"CREATE TABLE IF NOT EXISTS 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255),'car_price'VARCHAR(255)) ";
//        
//        [_db executeUpdate:personSql];
//        [_db executeUpdate:carSql];
//        
//    }else{
//        NSLog(@"数据库打开失败");
//    }
//    
//    
//}
//
//@end

