//
//  HPPhotoPickerController.h
//  photo
//
//  Created by 雷建民 on 17/1/11.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HPPhotoPickerController;

@protocol HPPhotoPickerControllerDelegate <NSObject>

- (void)imagePickerController:(HPPhotoPickerController *)picker didFinishPickingWithImage:(UIImage *)image;

@end

@interface HPPhotoPickerController : UICollectionViewController

@property (nonatomic ,weak) id <HPPhotoPickerControllerDelegate> delegate;

/**
 照片 选择控制器 初始化 方法

 @param delegate  控制器代理
 @param isOvalClip 裁剪方式  YES : 正方形裁剪  NO ：圆形裁剪
 @param layout 控制器 layout
 @return self
 */
- (instancetype)initWithDelegate:(id)delegate
              isOvalClip:(BOOL)isOvalClip
              flowLayout:(UICollectionViewFlowLayout *)layout;

@end













@interface HPPickerImageViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *photo;

@end
