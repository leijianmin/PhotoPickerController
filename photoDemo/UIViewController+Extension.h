//
//  UIViewController+Extension.h
//  YanzijiaUser
//
//  Created by 雷建民 on 16/7/17.
//  Copyright © 2016年 雷建民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "NSObject+Extension.h"

typedef void (^LeftCallBack)(void);
typedef void (^RightCallBack)(void);

typedef void (^OneActionCallBack)(UIAlertAction *oneAction);
typedef void (^TwoActionCallBack)(UIAlertAction *twoAction);


@interface UIViewController (Extension)

/**
 *   左边 item block回调
 */
@property (nonatomic,copy)LeftCallBack leftCallBack;
/**
 *  右边 item block回调
 */
@property (nonatomic,copy)RightCallBack rightCallBack;
/**
 *  提示框 左边action 回调
 */
@property (nonatomic,copy)OneActionCallBack OneActionCallBack;

/**
 *  提示框 右边action 回调
 */
@property (nonatomic,copy)TwoActionCallBack TwoActionCallBack;

#pragma mark - 视图控制器 左右item Action事件
/**
 *    @parma  title      左侧item 标题
 *    @parma  style      左侧item的样式
 *    @parma  callBack   左侧item Action事件回调
 */
- (void)addActionWithLeftBarItem:(NSString *)title
                           style:(UIBarButtonItemStyle)style
                        callBack:(LeftCallBack)callBack;

/**
 *    @parma  imageName  左侧图片的名称
 *    @parma  style      左侧item的样式
 *    @parma  callBack   左侧item Action事件回调
 */
- (void)addActionWithLeftBarImage:(NSString *)imageName
                            style:(UIBarButtonItemStyle)style
                         callBack:(LeftCallBack)callBack;


/**
 *    @parma  title      右侧item 标题
 *    @parma  style      右侧item的样式
 *    @parma  callBack   右侧item Action事件回调
 */
- (void)addActionWithRightBarItem:(NSString *)title
                           style:(UIBarButtonItemStyle)style
                        callBack:(RightCallBack)callBack;

/**
 *    @parma  imageName  右侧图片的名称
 *    @parma  style      右侧item的样式
 *    @parma  callBack   右侧item Action事件回调
 */

- (void)addActionWithRightBarImage:(NSString *)imageName
                            style:(UIBarButtonItemStyle)style
                         callBack:(RightCallBack)callBack;


/**
 只有一个确定按钮的弹窗提示

 @param message 提示信息
 */
- (void)showMessage:(NSString *)message;


/**
 有 确定和 取消 按钮的 提示框

 @param message 提示信息
 */
- (void)showMessageTwoAction:(NSString *)message
                  TwoHandler:(void (^)(UIAlertAction *))TwoHandler;

/*
 *   @parma  title              弹窗提示的 标题
 *   @parma  message            弹窗提示的文字信息
 *   @parma  style              弹窗的样式
 *   @parma  oneActionTitle     左边action的标题
 *   @parma  twoActionTitle     右边action的标题
 *   @parma  OneActionCallBack  左边action事件回调
 *   @parma  TwoActionCallBack  右边action事件回调
 */
- (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                           style:(UIAlertControllerStyle)style
                  oneActionTitle:(NSString *)oneActionTitle
                  twoActionTitle:(NSString *)twoActionTitle
                  OneActionStyle:(UIAlertActionStyle)OneActionStyle
                  TwoActionStyle:(UIAlertActionStyle)TwoActionStyle
                         OneHandler:(void (^)(UIAlertAction *OneAction))OneHandler
                         TwoHandler:(void (^)(UIAlertAction *TwoAction))TwoHandler;





#pragma mark - 定位 功能方法

- (void)addCllocationRequest:(CLLocationManager *)manager;

#pragma mark - 左侧item 返回 图片按钮 事件


/**
 导航栏返回 事件
 */
- (void)back;

/**
 隐藏导航栏左侧item
 */
- (void)hiddenNavigationLeftItem;

/**
 模态出一个半透明控制器
 
 @param customView 自定义view
 */
- (void)presentToHPTranslucencyController:(UIView *)customView;


/**
 dismiss 掉 半透明控制器
 */
- (void)dismissToHPTranslucencyController;


/**
 添加 半透明view
 
 @param customView 半透明view的subview
 @param frame 半透明view的subview 要显示的位置
 */
- (void)changeWindowAlphaColorWithCustomView:(UIView *)customView frame:(CGRect)frame;

/**
 点击空白区域 取消显示 半透明view
 */
- (void)changeAlphaAndColor;

 



/**
 保存图片到 document

 @param image 保存的图片
 @param name 需要保存的图片名字
 */
- (void)saveImageToDocument:(UIImage *)image name:(NSString *)name;

/**
 根据名字获取图片路径

 @param name 图片名字
 @return 路径
 */
- (NSString *)getPath:(NSString *)name;

/**
 图片进行base64 解码
 
 @param  需要解码的base64字符串
 @return 解码后的image
 */
- (UIImage *)fromBase64Image:(NSString *)base64;

/*
 *
 *  压缩图片至目标尺寸
 *
 *  @param sourceImage 源图片
 *  @param targetWidth 图片最终尺寸的宽
 *
 *  @return 返回按照源图片的宽、高比例压缩至目标宽、高的图片
 */
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;





@end
