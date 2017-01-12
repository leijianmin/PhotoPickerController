//
//  UIImage+Extension.m
//  HouPu
//
//  Created by 雷建民 on 17/1/3.
//  Copyright © 2017年 杭州后铺信息科技有限公司. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Photos/Photos.h>


@implementation UIImage (Extension)


const char  photoArrayKey;

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize

{
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}
/**
 保存图片到系统相册
 
 @param image image
 */
+ (void)saveImageWithPhotoLibrary:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
     
      [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
          //  [STTextHudTool showText:@"已保存至相册" withSecond:1];
        }
        NSLog(@"success = %d, error = %@", success, error);
    }];
}
 
/**
 获取系统相册中所有的缩略图 和原图
 缩略图  尺寸 大约 {32.5，60}   (allSmallImageArray 回调获取到的缩略图 图片数组)
 原图    尺寸 大约 屏幕等大     （allOriginalImageArray 回调获取到的大图 图片数组)
 
 */

+ (void)async_getLibraryPhoto:(void(^)(NSArray <UIImage *> *allSmallImageArray))smallImageCallBack
     allOriginalImageCallBack:(void(^)(NSArray <UIImage *> *allOriginalImageArray))allOriginalImageCallBack
{
   static UIImage *image;image = [UIImage new];
    dispatch_queue_t concurrencyQueue = dispatch_queue_create("getLibiaryAllImage-queue",
                                                              DISPATCH_QUEUE_CONCURRENT);
    // task 1 ：  先获得相册中所有 缩略图
    dispatch_async(concurrencyQueue, ^{
    NSMutableArray *smallPhotoArray = [NSMutableArray array];
        [smallPhotoArray addObjectsFromArray:[UIImage getImageWithScaleImage:image isOriginalPhoto:NO]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (smallImageCallBack) {
                smallImageCallBack([smallPhotoArray copy]);
            }
        });
    });
    // task 2 ：  获得相册中所有 原图
    dispatch_async(concurrencyQueue, ^{
        NSMutableArray *allOriginalPhotoArray = [NSMutableArray array];
      [allOriginalPhotoArray addObjectsFromArray:[UIImage getImageWithScaleImage:image isOriginalPhoto:YES]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (allOriginalImageCallBack) {
                allOriginalImageCallBack([allOriginalPhotoArray copy]);
            }
        });
        
    });
}
+ (NSArray <UIImage *> *)getImageWithScaleImage:(UIImage *)image isOriginalPhoto:(BOOL)isOriginalPhoto
{
    NSMutableArray *photoArray = [NSMutableArray array];
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [photoArray addObjectsFromArray:[image enumerateAssetsInAssetCollection:assetCollection original:isOriginalPhoto]];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [photoArray addObjectsFromArray:[image enumerateAssetsInAssetCollection:cameraRoll original:isOriginalPhoto]];
    return photoArray;
}


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (NSArray <UIImage *> *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSMutableArray *array = [NSMutableArray array];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
     for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
             [array addObject:result];
         }];
    }
     return array;
}

- (UIImage *)beginClip
{
    
    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
