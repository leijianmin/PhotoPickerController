//
//  ViewController.m
//  photoDemo
//
//  Created by 雷建民 on 17/1/8.
//  Copyright © 2017年 雷建民. All rights reserved.
//

#import "ViewController.h"
#import "HPAllImageGroupController.h"
@interface ViewController ()

@property(nonatomic, strong)UIImageView *testImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 40)];
    btn.backgroundColor =[UIColor redColor];
    [btn setTitle:@"打开相册" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(openXiangCe) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
    
    
    
    self.testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 120, 120)];
    self.testImageView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:self.testImageView];
}


-(void)openXiangCe
{
  /*  NSPredicate *pre = [NSPredicate predicateWithFormat:@"imageType = %ld AND pixelWidth >= 3000",0];
    ZCImagePickerController *picker =[[ZCImagePickerController alloc] initWithPredicate:pre singleSelect:NO];
    
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];*/
    HPAllImageGroupController *allImageVC = [[HPAllImageGroupController alloc]init];
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:allImageVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naviVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
