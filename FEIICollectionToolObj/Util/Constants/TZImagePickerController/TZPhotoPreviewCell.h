//
//  TZPhotoPreviewCell.h
//  TZImagePickerController
//
//  Created by shine-team1 on 15/12/24.
//  Copyright © 2015年 shine-team1 All rights reserved.
//

#import <UIKit/UIKit.h>

@class TZAssetModel;
@interface TZPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, strong) TZAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();

@end
