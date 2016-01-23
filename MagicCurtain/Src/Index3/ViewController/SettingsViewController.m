//
//  SettingsViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/1.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "SettingsViewController.h"
#import "ChangeArrayViewController.h"
#import "SiginViewController.h"
#import "MLImagesBrowserViewController.h"
#import "ChangePasswordViewController.h"
#import "ChooseViewController.h"
#import "SettingCell.h"
#import "HeadCell.h"
#import <UIImageView+WebCache.h>
#import "UserNavigationController.h"
#import "Index3Service.h"
#import "LoginOutCell.h"
#import "StatusModel.h"
#import "WebViewController.h"
@interface SettingsViewController ()<UIActionSheetDelegate,HeadCellDelegate,LoginOutDeleGate>
{
    NSArray *titleArray;
    LoginModel *user;
    Index3Service *index3Service;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index3Service=[Index3Service new];
    self.title=@"设置";
    titleArray=@[@"",@"昵       称",@"用  户  名",@"地       址",@"密码设置",@"联系我们",@"关于我们"];
    self.tableView.tableFooterView=[UIView new];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    if (section==1||section==3||section==5) {
        return 8;
    }else if(section ==7){
        return 80;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section =indexPath.section;
    if (section==0) {
        HeadCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HeadCell" forIndexPath:indexPath];
        [cell.headPic sd_setImageWithURL:[NSURL URLWithString:user.head_image] placeholderImage:nil];
        cell.delegate=self;
        return cell;
    }else if(section==7){
        LoginOutCell*cell =[tableView dequeueReusableCellWithIdentifier:@"LoginOutCell" forIndexPath:indexPath];
        cell.delegate=self;
        return cell;
    }else{
        SettingCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
        cell.title.text=titleArray[section];
        if (indexPath.section==1) {
            cell.detail.text=user.nick_name;
            cell.detail.hidden=NO;
        }else if(indexPath.section==2){
            cell.detail.text=user.login_name;
            cell.detail.hidden=NO;
        }else{
            cell.detail.hidden=YES;
        }
        if (indexPath.section==7) {
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section==0) {
        return 65;
    }
    if (indexPath.section==7) {
        return 47;
    }
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        action.tag=1;
        [action showInView:self.view.window];
    }else if(indexPath.section==1){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        SiginViewController *siginViewController =[storyboard instantiateViewControllerWithIdentifier:@"SiginViewController"];
        siginViewController.detailString=user.nick_name;
        siginViewController.changeType=0;
        [self.navigationController pushViewController:siginViewController animated:YES];
    }else if(indexPath.section==2){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        SiginViewController *siginViewController =[storyboard instantiateViewControllerWithIdentifier:@"SiginViewController"];
        siginViewController.detailString=user.login_name;
        siginViewController.changeType=1;
        [self.navigationController pushViewController:siginViewController animated:YES];
    }else if (indexPath.section==3){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            ChangeArrayViewController *changeArrayViewController =[storyboard instantiateViewControllerWithIdentifier:@"ChangeArrayViewController"];
            [self.navigationController pushViewController:changeArrayViewController animated:YES];
    }else if(indexPath.section==4){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        ChangePasswordViewController *changePasswordViewController =[storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        changePasswordViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:changePasswordViewController animated:YES];
    }else if(indexPath.section==5){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [index3Service memberwithViewController:self ContactWithDone:^(StatusModelInfo *model){
            NSString *tel = [NSString stringWithFormat:@"tel:%@",model.phone];
            UIWebView *callWebview = [[UIWebView alloc] init];
            NSURL *telURL = [NSURL URLWithString:tel];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self.view addSubview:callWebview];
        }];
    }else if(indexPath.section==6){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [index3Service memberwithViewController:self  AboutWithDone:^(StatusModelInfo *model){
            WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
            target.navigationController.navigationItem.leftBarButtonItem.title=@"首页";
            target.title=@"关于我们";
            target.urlString = model.about_url;
            target.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:target animated:YES];
            
        }];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
}


#pragma LoginOutDeleGate
-(void)loginOut{
    SharedData *sharedData =[SharedData sharedInstance];
    UIAlertController *alertViewcontroller=[UIAlertController alertControllerWithTitle:@"退出登录" message:@"您是否退出当前账号"  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
           }];
    UIAlertAction*okAction= [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        sharedData.user=nil;
        sharedData.loginname=@"";
        sharedData.password=@"";
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
        UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
        [self presentViewController:userNavi animated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginOut" object:nil];
    }];
    [alertViewcontroller addAction:cancelAction];
    [alertViewcontroller addAction:okAction];
    [self presentViewController:alertViewcontroller animated:YES completion:nil];
}


#pragma HeadCellDelegate
-(void)showBigPic{
    MLImagesBrowserViewController *target = [[MLImagesBrowserViewController alloc] initWithNibName:@"MLImagesBrowserViewController" bundle:nil];
    target.imageType = UIImageUrlType;
    target.imgUrls = @[user.head_image];//（必填）
    target.defaultLocationIndex = 0;//这一步必须放在最后。（可选）
    [self.navigationController pushViewController:target animated:YES];
}

//相机相关
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance]:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[SharedAction colorWithHexString:@"00B050"]];
    if (buttonIndex==0) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex==1){
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=nil;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]  setBackgroundColor:[SharedAction colorWithHexString:@"00B050"]];
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    [index3Service memberHeadWithMid:user.mid andSecret:user.secret andHeadImage:image withViewController:self withDone:^(StatusModel *model){
        if (model.status==2) {
            StatusModelInfo *models=model.info;
            [SVProgressHUD showSuccessWithStatus:model.msg];
            SharedData *sharedData =[SharedData sharedInstance];
            sharedData.user.head_image=models.head_image;
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.msg];
        }
            [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
@end
