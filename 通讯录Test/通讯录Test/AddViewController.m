//
//  AddViewController.m
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AddViewController.h"

#import "ContactModel.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backAction;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *CallField;
@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
- (IBAction)AddCon;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加通知中心     观察者监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.CallField];
}
- (void)textChange{
    self.AddBtn.enabled=(self.nameField.text.length&&self.CallField.text.length);
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //让姓名文本框称为第一响应者(叫出键盘)
    [self.nameField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//添加联系人
- (IBAction)AddCon {
    //1.关闭当前的视图控制器----返回到联系人界面
    [self.navigationController popViewControllerAnimated:YES];
    //代理传值------反向传值
    if ([self.delegate respondsToSelector:@selector(addContact:didAddContact:)]) {
        ContactModel *model=[[ContactModel alloc]init];
        model.nameStr=self.nameField.text;
        model.iphoneStr=self.CallField.text;
        
        [self.delegate addContact:self didAddContact:model];
    }
    
    
}
@end
