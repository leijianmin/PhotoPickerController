//
//  UIViewController+Extension.m
//  YanzijiaUser
//
//  Created by 雷建民 on 16/7/17.
//  Copyright © 2016年 雷建民. All rights reserved.
//



#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#import "UIViewController+Extension.h"
#import <objc/runtime.h>
//#import "HPTranslucencyController.h"
@interface UIViewController ()

@property (nonatomic ,strong) UIButton *layerView;
@property (nonatomic ,strong) UIView  *customView;
@end


@implementation UIViewController (Extension)


const char  leftCallBackKey;
const char  rightCallBackKey;
const char  oneActionCallBackKey;
const char  twoActionCallBackKey;
const char  layerViewKey;
const char  customViewKey;

- (void)addActionWithLeftBarItem:(NSString *)title
                           style:(UIBarButtonItemStyle)style
                        callBack:(LeftCallBack)callBack
{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:style target:self action:@selector(leftCallBackAction)];
    self.leftCallBack = callBack;
    
}

- (void)addActionWithLeftBarImage:(NSString *)imageName
                            style:(UIBarButtonItemStyle)style
                         callBack:(LeftCallBack)callBack
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:style target:self action:@selector(leftCallBackAction)];
    
    self.leftCallBack = callBack;
    
}

- (void)addActionWithRightBarItem:(NSString *)title
                            style:(UIBarButtonItemStyle)style
                         callBack:(RightCallBack)callBack
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:style target:self action:@selector(rightCallBackAction)];
    self.rightCallBack = callBack;
}

- (void)addActionWithRightBarImage:(NSString *)imageName
                             style:(UIBarButtonItemStyle)style
                          callBack:(RightCallBack)callBack
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:style target:self action:@selector(rightCallBackAction)];
    self.rightCallBack = callBack;
    
}

/**
 只有一个确定按钮的弹窗提示
 
 @param message 提示信息
 */
- (void)showMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:oneAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 有 确定和 取消 按钮的 提示框
 
 @param message 提示信息
 */
- (void)showMessageTwoAction:(NSString *)message
                  TwoHandler:(void (^)(UIAlertAction *))TwoHandler

{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:oneAction];

    UIAlertAction *twoAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:TwoHandler];
    
    [alert addAction:twoAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                           style:(UIAlertControllerStyle)style
                  oneActionTitle:(NSString *)oneActionTitle
                  twoActionTitle:(NSString *)twoActionTitle
                  OneActionStyle:(UIAlertActionStyle)OneActionStyle
                  TwoActionStyle:(UIAlertActionStyle)TwoActionStyle
                      OneHandler:(void (^)(UIAlertAction *))OneHandler
                      TwoHandler:(void (^)(UIAlertAction *))TwoHandler
{
    WS(weakSelf);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:oneActionTitle style:OneActionStyle handler:^(UIAlertAction * action) {
        [weakSelf setOneAction:action];
    }];
    self.OneActionCallBack = OneHandler;
    [alert addAction:oneAction];
    if ( twoActionTitle && TwoHandler ) {
        UIAlertAction *twoAction = [UIAlertAction actionWithTitle:twoActionTitle style:TwoActionStyle handler:^(UIAlertAction * action) {
            [weakSelf setTwoAction:action];
        }];
        self.TwoActionCallBack = TwoHandler;
        [alert addAction:twoAction];
    }
    
    if (![title isEqualToString:@"温馨提示"]) {
        UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancalAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addCllocationRequest:(CLLocationManager *)manager
{
    manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [manager requestWhenInUseAuthorization];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [manager startUpdatingLocation];
    }
}

- (void)back
{
    WS(weakSelf);
    [self addActionWithLeftBarImage:@"icon_return_white" style:UIBarButtonItemStylePlain callBack:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}




/**
 隐藏导航栏左侧item
 */
- (void)hiddenNavigationLeftItem
{
    self.navigationItem.leftBarButtonItem = nil;
}


/*
- (void)presentToHPTranslucencyController:(UIView *)customView
{
    [[HPCustomRefreshGIFImageView shardGIFImageView]startAnimation];
    HPTranslucencyController *translucencyVC = [[HPTranslucencyController alloc]init];
    self.definesPresentationContext = YES;
    translucencyVC.backgroundBtn.hidden = YES;
    [translucencyVC.view addSubview:customView];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:translucencyVC animated:YES completion:^{
        translucencyVC.backgroundBtn.hidden = NO;
        [[HPCustomRefreshGIFImageView shardGIFImageView]stopAnimation];
    }];
}
*/

/**
 dismiss 掉 半透明控制器
 */
- (void)dismissToHPTranslucencyController
{
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:NO completion:nil];
}



/**
 添加 半透明view

 @param customView 半透明view的subview
 @param frame 半透明view的subview 要显示的位置
 */
- (void)changeWindowAlphaColorWithCustomView:(UIView *)customView frame:(CGRect)frame
{
    if (!self.layerView) {
        self.layerView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.layerView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    }
    self.layerView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.layerView];
    [self.layerView  addSubview:customView];
    [UIView animateWithDuration:0.3 animations:^{
        customView.frame = frame;
    }];
    self.customView = customView;
    [self.layerView  addTarget:self action:@selector(changeAlphaAndColor) forControlEvents:UIControlEventTouchUpInside];
}


/**
 点击空白区域 取消显示 半透明view
 
- (void)changeAlphaAndColor
{
    [UIView animateWithDuration:0.3 animations:^{
        self.layerView.backgroundColor = [UIColor clearColor];        
        self.customView.frame = CGRectMake(0, HPKHeight, self.customView.width, self.customView.height);
    } completion:^(BOOL finished) {
        [self.layerView removeFromSuperview];
    }];
}

 */



/**
 图片 进行base64 编码
 
 @return base64字符串
 */
- (void)saveImageToDocument:(UIImage *)image name:(NSString *)name
{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@%@.jpeg",NSHomeDirectory(),@"/Documents/",name];
    [UIImageJPEGRepresentation(image, 0.5) writeToFile:imagePath atomically:YES];
    
}



/**
 根据名字获取路径
 
 @param name 图片名字
 @return 路径
 */
- (NSString *)getPath:(NSString *)name
{
    return  [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents/",name];
}
/**
 图片进行base64 解码
 
 @param  需要解码的base64字符串
 @return 解码后的image
 */
- (UIImage *)fromBase64Image:(NSString *)base64
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

/*
 *
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}




#pragma mark - 点击事件

- (void)leftCallBackAction
{
    if (self.leftCallBack) {
        self.leftCallBack();
    }
}
- (void)rightCallBackAction
{
    if (self.rightCallBack) {
        self.rightCallBack();
    }
    
}

- (void)setOneAction:(UIAlertAction *)oneAction
{
    if (self.OneActionCallBack) {
        self.OneActionCallBack(oneAction);
    }
}

- (void)setTwoAction:(UIAlertAction *)twoAction
{
    if (self.TwoActionCallBack) {
        self.TwoActionCallBack(twoAction);
    }
}
#pragma mark - set && get 方法

- (void)setLeftCallBack:(LeftCallBack)leftCallBack
{
    objc_setAssociatedObject(self, &leftCallBackKey, leftCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LeftCallBack)leftCallBack
{
    return objc_getAssociatedObject(self, &leftCallBackKey);
}

- (void)setRightCallBack:(RightCallBack)rightCallBack
{
    objc_setAssociatedObject(self, &rightCallBackKey, rightCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (RightCallBack)rightCallBack
{
    return objc_getAssociatedObject(self, &rightCallBackKey);
}

- (void)setOneActionCallBack:(OneActionCallBack)OneActionCallBack
{
    objc_setAssociatedObject(self, &oneActionCallBackKey, OneActionCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (OneActionCallBack)OneActionCallBack
{
    return objc_getAssociatedObject(self, &oneActionCallBackKey);
    
}

- (void)setTwoActionCallBack:(TwoActionCallBack)TwoActionCallBack
{
    objc_setAssociatedObject(self, &twoActionCallBackKey, TwoActionCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (TwoActionCallBack)TwoActionCallBack
{
    return objc_getAssociatedObject(self, &twoActionCallBackKey);
    
}

- (void)setLayerView:(UIButton *)layerView
{
    objc_setAssociatedObject(self, &layerViewKey, layerView , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)layerView
{
    return  objc_getAssociatedObject(self, &layerViewKey);
}

- (void)setCustomView:(UIView *)customView
{
    objc_setAssociatedObject(self, &customViewKey, customView , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customView
{
    return objc_getAssociatedObject(self, &customViewKey);
}
@end
