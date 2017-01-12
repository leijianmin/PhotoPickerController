//
//  HPPhotoPickerController.m
//  photo
//
//  Created by 雷建民 on 17/1/11.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#import "HPPhotoPickerController.h"
#import "UIImage+Extension.h"
#import "HPPhotoPickerDetailController.h"

@class HPPickerImageViewCell;

@interface HPPhotoPickerController ()<UICollectionViewDelegateFlowLayout>
{
    BOOL  _isOvalClip;
}
@property (nonatomic ,strong) NSMutableArray *smallphotoArray;
@property (nonatomic ,strong) NSMutableArray *bigPhotoArray;

@end

@implementation HPPhotoPickerController

static NSString * const reuseIdentifier = @"Cell";


- (void)getData
{
    [UIImage async_getLibraryPhoto:^(NSArray<UIImage *> *allSmallImageArray) {
        NSLog(@"***小**%ld",allSmallImageArray.count);
        [self.smallphotoArray addObjectsFromArray:allSmallImageArray];
        [self.collectionView reloadData];
    } allOriginalImageCallBack:^(NSArray<UIImage *> *allOriginalImageArray) {
        NSLog(@"***大**%ld",allOriginalImageArray.count);
        [self.bigPhotoArray addObjectsFromArray:allOriginalImageArray];
        [self.collectionView reloadData];
    }];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    if (self.smallphotoArray.count > 0) {
        return self.smallphotoArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HPPickerImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photo.image = self.smallphotoArray[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bigPhotoArray.count > 0) {
        HPPhotoPickerDetailController *detailVC = [[HPPhotoPickerDetailController alloc]initWithImage:self.bigPhotoArray[indexPath.row] delegate:self];
        detailVC.ovalClip = _isOvalClip;
         [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - CropImageDelegate
- (void)cropImageDidFinishedWithImage:(UIImage *)image
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingWithImage:)]) {
        [self.delegate imagePickerController:self didFinishPickingWithImage:image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 初始化
- (instancetype)initWithDelegate:(id)delegate
              isOvalClip:(BOOL)isOvalClip
              flowLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        _delegate = delegate;
        _isOvalClip = isOvalClip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    self.navigationItem.title = @"所有照片";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[HPPickerImageViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 懒加载
- (NSMutableArray *)smallphotoArray
{
    if (!_smallphotoArray) {
        _smallphotoArray = [NSMutableArray array];
    }
    return _smallphotoArray;
}
- (NSMutableArray *)bigPhotoArray
{
    if (!_bigPhotoArray) {
        _bigPhotoArray = [NSMutableArray array];
    }
    return _bigPhotoArray;
}
@end


@implementation HPPickerImageViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photo];
    }
    return self;
}

- (UIImageView *)photo
{
    if (!_photo) {
        _photo = [[UIImageView alloc]initWithFrame:self.contentView.frame];
    }
    return _photo;
}


@end
