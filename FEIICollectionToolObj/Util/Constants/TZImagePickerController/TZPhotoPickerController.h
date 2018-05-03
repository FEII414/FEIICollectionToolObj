//
//  TZPhotoPickerController.h
//  TZImagePickerController
//
//  Created by shine-team1 on 15/12/24.
//  Copyright © 2015年 shine-team1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TZAlbumModel;
@interface TZPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, strong) TZAlbumModel *model;

@property (nonatomic, copy) void (^backButtonClickHandle)(TZAlbumModel *model);

@end
