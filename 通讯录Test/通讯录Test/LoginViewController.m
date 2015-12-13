//
//  LoginViewController.m
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"



#define UserNameKey @"name"
#define PwdKey @"pwd"
#define RmbPwKey @"rmb_pwd"//记住密码开关
@interface LoginViewController ()

//一下是账号名和密码已经记住密码开关
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *remSwitch;
@property (weak, nonatomic) IBOutlet UIButton *Login;
- (IBAction)LoginAction;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加通知中心     观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
    
    //读取上次配置
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    self.nameField.text=[defaults valueForKey:UserNameKey];
    
    self.pwdField.text=[defaults valueForKey:PwdKey];
    self.remSwitch.on=[defaults boolForKey:RmbPwKey];
    if (self.remSwitch.isOn) {
        self.pwdField.text=[defaults valueForKey:PwdKey];
        self.Login.enabled=YES;
    }
    
}
- (void)textChange{
    /*
    if (self.nameField.text.length&&self.pwdField.text.length) {
        //当用户名和密码都不为空时候登陆按钮才可以点击
        self.Login.enabled=YES;
    }else{
        self.Login.enabled=NO;
    }*/
    
    //这句话等价于上面条件判断
    self.Login.enabled=(self.nameField.text.length&&self.pwdField.text.length);
}
- (void)viewDidAppear:(BOOL)animated{
    [self.nameField becomeFirstResponder];
    [self.pwdField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//登陆事件
- (IBAction)LoginAction {
    
//    if (![self.nameField.text isEqualToString:@"jike"]) {
//        
//    }
    [self performSegueWithIdentifier:@"LogtoContact" sender:nil];
    
    //存储数据
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserNameKey];
    [defaults setObject:self.pwdField.text forKey:PwdKey];
    [defaults setBool:self.remSwitch forKey:RmbPwKey];
    //设置同步磁盘
    [defaults synchronize];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//跳转之前执行
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //1.取得目标控制器
    UIViewController *contactVC=segue.destinationViewController;
    //2.设置标题
    contactVC.title=[NSString stringWithFormat:@"%@的联系人列表",self.nameField.text];
}



@end
