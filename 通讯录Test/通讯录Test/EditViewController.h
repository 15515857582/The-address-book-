//
//  EditViewController.h
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactModel,EditViewController;


@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)enditViewController:(EditViewController *)editVC didSaveContact:(ContactModel *)model;

@end
@interface EditViewController : UIViewController
@property(nonatomic,strong)ContactModel *model;

@property(nonatomic,assign)id<EditViewControllerDelegate>delegate;
@end
