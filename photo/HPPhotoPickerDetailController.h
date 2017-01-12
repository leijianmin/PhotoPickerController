//
//  HPPhotoPickerDetailController.h
//  photo
//
//  Created by 雷建民 on 17/1/11.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropImageDelegate <NSObject>

- (void)cropImageDidFinishedWithImage:(UIImage *)image;

@end

@interface HPPhotoPickerDetailController : UIViewController


@property (nonatomic, weak) id <CropImageDelegate> delegate;
//圆形裁剪，默认NO;
@property (nonatomic, assign) BOOL ovalClip;
- (instancetype)initWithImage:(UIImage *)originalImage delegate:(id)delegate;

@end
