//
//  ContactTableViewController.m
//  通讯录Test
//
//  Created by apple on 15/12/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ContactTableViewController.h"

#import "ContactModel.h"
#import "AddViewController.h"

#import "EditViewController.h"


#define ContactFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"contacts.data"]
@interface ContactTableViewController ()<AddViewControllerDelgate,EditViewControllerDelegate>//遵守代理方法
- (IBAction)backAction:(id)sender;
@property(nonatomic,strong)NSMutableArray *contactArr;

@end

@implementation ContactTableViewController
//懒加载方式
- (NSMutableArray *)contactArr{
    if (!_contactArr) {
        _contactArr=[NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if (_contactArr==nil) {
            _contactArr=[NSMutableArray array];
        }
    }
    return _contactArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self clearExtraLine:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.contactArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    ContactModel *model=self.contactArr[indexPath.row];
    cell.textLabel.text=model.nameStr;
    cell.detailTextLabel.text=model.iphoneStr;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}
#pragma mark -------代理方法

- (void)addContact:(AddViewController *)addVC didAddContact:(ContactModel *)contact{
    //1.添加数据模型
    [self.contactArr addObject:contact];
    //.2.刷新表格视图
    [self.tableView reloadData];
    
    
    //3.归档
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
    
}

#pragma mark - 去掉多余的线
- (void)clearExtraLine:(UITableView *)tableView{

    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    [self.tableView setTableFooterView:view];
}




#pragma mark -Edit delegate
-(void)enditViewController:(EditViewController *)editVC didSaveContact:(ContactModel *)model{

    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    
    /*AddViewController *addVc=segue.destinationViewController;
    addVc.delegate=self;*/
    
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addVc=vc;
        addVc.delegate=self;
        
    }else if([vc isKindOfClass:[EditViewController class]]){
         EditViewController *edVc=vc;
        
        //取得选中的那行
        NSIndexPath *path=[self.tableView indexPathForSelectedRow];
        edVc.model=self.contactArr[path.row];
       
        edVc.delegate=self;
    }
}

#pragma mark -UITableView delaget
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //1.删除数据模型
        [self.contactArr removeObjectAtIndex:indexPath.row];
        //2.刷新表格视图
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        //3.归档
        [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
    }
}

//点击注销按钮时候事件
- (IBAction)backAction:(id)sender {
    //初始化   UIAlertController集合了UIAlertView&UIActionSheet
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否注销" message:@"真的要注销吗" preferredStyle:UIAlertControllerStyleActionSheet];
    //添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    
    //弹出alert框
    [self presentViewController:alert animated:YES completion:nil];
}
@end
