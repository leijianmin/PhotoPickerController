//
//  UIImage+Extension.h
//  HouPu
//
//  Created by 雷建民 on 17/1/3.
//  Copyright © 2017年 杭州后铺信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 颜色转化为图片

 @param color 入参 颜色
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 等比例缩放图片 方法

 @param image 要缩放的 image
 @param scaleSize 缩放比例
 @return  缩放后的image
 */
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 保存图片到系统相册  （无法找到取出）

 @param image image
 */
+ (void)saveImageWithPhotoLibrary:(UIImage *)image;


/**
 获取系统相册中所有的缩略图 和原图 
 缩略图  尺寸 大约 {32.5，60}   (allSmallImageArray 回调获取到的缩略图 图片数组)
 原图    尺寸 大约 屏幕等大     （allOriginalImageArray 回调获取到的大图 图片数组)

 */
+ (void)async_getLibraryPhoto:(void(^)(NSArray <UIImage *> *allSmallImageArray))smallImageCallBack
     allOriginalImageCallBack:(void(^)(NSArray <UIImage *> *allOriginalImageArray))allOriginalImageCallBack;



/**
 裁剪 图片

 @return image
 */
- (UIImage *)beginClip;



@end
