//
//  AddViewController.h
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class 前向引用声明
@class AddViewController,ContactModel;


//AddViewControllerDelgate协议名字
@protocol AddViewControllerDelgate <NSObject>

@optional
//可选协议方法
- (void)addContact:(AddViewController *)addVC didAddContact:(ContactModel *)contact;

@end
@interface AddViewController : UIViewController

//设置代码  用assign
@property(nonatomic,assign)id<AddViewControllerDelgate>delegate;
@end
