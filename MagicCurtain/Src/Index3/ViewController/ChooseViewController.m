//
//  ChooseViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ChooseViewController.h"
#import "ChooseChanegCell.h"
#import "ChangePasswordViewController.h"
@interface ChooseViewController ()
{
    NSArray *titleArray;
}
@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    titleArray=@[@"修改登录密码",@"修改支付密码"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseChanegCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ChooseChanegCell" forIndexPath:indexPath];
    cell.title.text=titleArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    ChangePasswordViewController *changePasswordViewController=[storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    changePasswordViewController.title=titleArray[indexPath.row];
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}
@end
