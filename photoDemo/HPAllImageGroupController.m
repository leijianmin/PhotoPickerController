//
//  HPAllImageGroupController.m
//  photoDemo
//
//  Created by 雷建民 on 17/1/8.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#import "HPAllImageGroupController.h"
#import "HPImagePickerController.h"
#import "UIViewController+Extension.h"
#import <Photos/Photos.h>
@interface HPAllImageGroupController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *photoListTitle; //相册名字 数据源
    NSMutableArray *photoListNumber; //相册文件夹 内图片数量数据源
}
@property (nonatomic ,strong) UITableView *photoListTableView;

@property (nonatomic ,strong) NSMutableDictionary *photoListDict;
@property (nonatomic ,strong) NSMutableArray *photoListArray;
@end

@implementation HPAllImageGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationView];
    [self pushAction];
}

- (void)setNavigationView
{
    self.navigationItem.title = @"照片";
    [self addActionWithRightBarItem:@"取消" style:UIBarButtonItemStylePlain callBack:^{
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)pushAction
{
    HPImagePickerController *imageVC = [[HPImagePickerController alloc]init];
    [self.navigationController pushViewController:imageVC animated:YES];
    [self getAllAssetInPhotoAblumWithAscending:YES];
}

#pragma mark - 获取相册内所有照片资源
- (NSMutableArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending
{
    WS(weakSelf);
  __block  NSMutableDictionary *dict;
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
    }];
     PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //异步遍历 获取所有自定义相册
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dict   = [NSMutableDictionary dictionary];
            [self.photoListArray addObject:self.photoListDict];
             [weakSelf.photoListDict setObject:obj.localizedTitle forKey:[NSString stringWithFormat:@"%ld",idx+1]];
            NSLog(@"+++%@----%@",obj.localizedTitle,self.photoListDict);
        }];

    });
    
       
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    
    [result enumerateObjectsUsingBlock:^(PHAsset  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSLog(@"照片名%@ obj.title = %@", [obj valueForKey:@"filename"],obj);
        [assets addObject:obj];
    }];
     NSLog(@"%ld",assets.count);
    return assets;
}


#pragma mark - UITableViewDataSource


- (UITableView *)photoListTableView
{
    if (!_photoListTableView) {
        _photoListTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _photoListTableView.delegate = self;
        _photoListTableView.dataSource = self;
    }
    return _photoListTableView;
}

- (NSMutableDictionary *)photoListDict
{
    if (!_photoListDict) {
        _photoListDict = [NSMutableDictionary dictionary];
        
    }
    return [_photoListDict copy];
}

- (NSMutableArray *)photoListArray
{
    if (!_photoListArray) {
        _photoListArray = [NSMutableArray array];
    }
    return _photoListArray;
}
@end
