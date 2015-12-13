//
//  EditViewController.m
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "EditViewController.h"
#import "ContactModel.h"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)SaveAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Edit;
- (IBAction)EditAction:(UIBarButtonItem *)sender;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text=self.model.nameStr;
    self.phoneField.text=self.model.iphoneStr;
    
    
    
    //添加通知中心     观察者监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];

}
- (void)textChange{

    self.saveBtn.enabled=(self.nameField.text.length&&self.phoneField.text.length);
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


//保存按钮
- (IBAction)SaveAction {
    //1.关闭当前页码
    [self.navigationController popViewControllerAnimated:YES];
    //2.通知代码
    if ([self.delegate respondsToSelector:@selector(enditViewController:didSaveContact:)]) {
        //更新数据模型
        self.model.nameStr=self.nameField.text;
        self.model.iphoneStr=self.phoneField.text;
        [self.delegate enditViewController:self didSaveContact:self.model];
    }
}

- (IBAction)EditAction:(UIBarButtonItem *)sender {
    
    if (self.nameField.enabled) {
        self.nameField.enabled=NO;
        self.phoneField.enabled=NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden=YES;
        sender.title=@"编辑";
        //还原回原来的数据
        self.nameField.text=self.model.nameStr;
        self.phoneField.text=self.model.iphoneStr;
    }else{
        self.nameField.enabled=YES;
        self.phoneField.enabled=YES;
        self.saveBtn.hidden=NO;
        sender.title=@"取消";
    }
}
@end
