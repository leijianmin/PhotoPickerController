//
//  ViewController.m
//  photo
//
//  Created by 雷建民 on 17/1/11.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#import "ViewController.h"
#import "HPPhotoPickerController.h"
@interface ViewController ()

@property(nonatomic, strong)UIImageView *testImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    btn.backgroundColor =[UIColor magentaColor];
    [btn setTitle:@"打开相册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openXiangCe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 120, 120)];
    self.testImageView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:self.testImageView];

}

- (void)openXiangCe
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((self.view.frame.size.width-20)/4,(self.view.frame.size.width-20)/4);
    HPPhotoPickerController *pickerVC = [[HPPhotoPickerController alloc]initWithDelegate:self isOvalClip:YES flowLayout:layout];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:pickerVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)imagePickerController:(HPPhotoPickerController *)picker didFinishPickingWithImage:(UIImage *)image
{
    NSLog(@"////////%@///////%@",image,picker);
    self.testImageView.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
