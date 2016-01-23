//
//  Index3ViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index3ViewController.h"
#import "DsrMainScrollView.h"
#import "RecordViewController.h"
#import "CollectViewController.h"
#import "VipMemberViewController.h"
#import "FcodeViewController.h"
#import "DsrMainScrollView.h"
#import "SettingsViewController.h"
#import "AuthenticationViewController.h"
#import "UserNavigationController.h"
#import "AuthenticationNavigationController.h"
#import "TuijianListViewController.h"
#import "MyMesageViewController.h"
#import "UserListCell.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#import "Index3Service.h"
#import "StudyModel.h"
#import <UIImageView+WebCache.h>
#import "StatusModel.h"
#import "RefModel.h"
#import "PointModel.h"
#import "MemberMessageModel.h"
#import "WebViewController.h"
@interface Index3ViewController ()<UIActionSheetDelegate,DsrMainScrollViewDelegate>
{
    LoginModel *user;
    NSArray *titleArray;
    NSArray *imageArray;
    Index3Service *index3Service;
}

@end

@implementation Index3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我";
    index3Service=[Index3Service new];
    self.tableView.tableFooterView=[UIView new];
    titleArray=@[@"学习记录",@"课程收藏",@"我的分享",@"我的订阅",@"我的推荐",@"我的留言"];
    imageArray=@[@"study",@"collect",@"shareGay",@"dingyue",@"tuijian",@"write"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoginSuccessAction) name:@"LoginSuccess" object:nil];
    
    self.headerPic.layer.cornerRadius=31;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self LoginSuccessAction];
}

-(void)setScrollView{
    DsrMainScrollView *dsrScrollview =[[DsrMainScrollView alloc] initWithFrame:CGRectMake(0, 110+self.navigationController.navigationBar.frame.size.height+22, DeviceFrame.size.width, DeviceFrame.size.height-110-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-22)];
    dsrScrollview.delegates=self;
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    RecordViewController *first=[storyboard instantiateViewControllerWithIdentifier:@"RecordViewController"];
    CollectViewController *second=[storyboard instantiateViewControllerWithIdentifier:@"CollectViewController"];
    VipMemberViewController *third=[storyboard instantiateViewControllerWithIdentifier:@"VipMemberViewController"];
    dsrScrollview.topFrame=64;
    [dsrScrollview initWithViewControllers:@[first,second,third]];
    [self.view addSubview:dsrScrollview];
}

-(void)LoginSuccessAction{
      SharedData *sharedData =[SharedData sharedInstance];
      user=sharedData.user;
    self.levelName.text=[NSString stringWithFormat:@"%@ %@",user.member_level,user.member_level_name];
    [self.point setTitle:[ NSString stringWithFormat:@"%ld",(long)user.point] forState:UIControlStateNormal];
    [self.headerPic sd_setImageWithURL:[NSURL URLWithString:user.head_image] placeholderImage:[UIImage imageNamed:@"tupian"]];
    if (user.member_audit==1) {
        [self.authenticationStatus setTitle:@"点击进行实名认证" forState:UIControlStateNormal];
    }else if (user.member_audit==2) {
        [self.authenticationStatus setTitle:@"正在等待平台审核" forState:UIControlStateNormal];    
    }else{
        [self.authenticationStatus setTitle:@"已认证" forState:UIControlStateNormal];
    }
    self.nickName.text=user.nick_name;
}

-(void)LoginAction{
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
    UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
    [self presentViewController:userNavi animated:YES completion:nil];
}

- (IBAction)settingAction:(id)sender {
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    SettingsViewController *settingsViewController=[storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    settingsViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (IBAction)shareAction:(id)sender {
    [index3Service memberSignWithMid:user.mid andSecret:user.secret withViewController:self withDone:^(PointModel *model){
        if (model.status==2) {
            PointModelInfo *models =model.info;
            SharedData *sharedData =[SharedData sharedInstance];
            sharedData.user.point = user.point + models.point;
            [self.point setTitle:[ NSString stringWithFormat:@"%ld",(long)sharedData.user.point] forState:UIControlStateNormal];
        }
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
}

- (IBAction)authenticationAction:(id)sender {
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    AuthenticationNavigationController *authenticationNavigationController=[storyboard instantiateViewControllerWithIdentifier:@"AuthenticationNavigationController"];
    authenticationNavigationController.hidesBottomBarWhenPushed=YES;
    [self presentViewController:authenticationNavigationController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    UserListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"UserListCell" forIndexPath:indexPath];
    cell.image.image=[UIImage imageNamed:imageArray[indexPath.row]];
    cell.title.text=titleArray[row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [index3Service memberStudyWithMid:user.mid andSercet:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(StudyModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            RecordViewController *recordViewController=[storyboard instantiateViewControllerWithIdentifier:@"RecordViewController"];
            recordViewController.hidesBottomBarWhenPushed=YES;
            recordViewController.lessonDataSouse=model.study;
            [self.navigationController pushViewController:recordViewController animated:YES];
        }];
        }else if(indexPath.row==1){
            [index3Service memberCollectWithMid:user.mid andSercet:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(StudyModelInfo *model){
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
                CollectViewController *collectViewController=[storyboard instantiateViewControllerWithIdentifier:@"CollectViewController"];
                collectViewController.hidesBottomBarWhenPushed=YES;
                collectViewController.lessonDataSouse=model.collect;
                [self.navigationController pushViewController:collectViewController animated:YES];
            }];
    }else if (indexPath.row==2){
        [index3Service memberShareWithMid:user.mid andSercet:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(StudyModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            VipMemberViewController *vipMemberViewController=[storyboard instantiateViewControllerWithIdentifier:@"VipMemberViewController"];
            vipMemberViewController.hidesBottomBarWhenPushed=YES;
            vipMemberViewController.lessonDataSouse=model.share;
            [self.navigationController pushViewController:vipMemberViewController animated:YES];
        }];
    }else if (indexPath.row==3){
        [index3Service memberBuyWithMid:user.mid andSercet:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(StudyModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            FcodeViewController *fcodeViewController=[storyboard instantiateViewControllerWithIdentifier:@"FcodeViewController"];
            fcodeViewController.hidesBottomBarWhenPushed=YES;
            fcodeViewController.lessonDataSouse=model.lesson;
            [self.navigationController pushViewController:fcodeViewController animated:YES];
        }];
    }else if(indexPath.row==4){
        [index3Service memberRefWithMid:user.mid andSecret:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(RefModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            TuijianListViewController *tuijianListViewController=[storyboard instantiateViewControllerWithIdentifier:@"TuijianListViewController"];
            tuijianListViewController.hidesBottomBarWhenPushed=YES;
            if (tuijianListViewController.dataSouce==nil) {
                tuijianListViewController.dataSouce =[NSMutableArray new];
            }
            tuijianListViewController.dataSouce=(NSMutableArray *)model.memeber;
            [self.navigationController pushViewController:tuijianListViewController animated:YES];
        }];
    }else {
        [index3Service memeberMesageWithMid:user.mid andSecret:user.secret andPage:@"1" andPageSize:@"120" withViewController:self withDone:^(MemberMessageDetail *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            MyMesageViewController *myMesageViewController=[storyboard instantiateViewControllerWithIdentifier:@"MyMesageViewController"];
            myMesageViewController.hidesBottomBarWhenPushed=YES;
            if (myMesageViewController.dataSouce ==nil) {
                myMesageViewController.dataSouce =[NSMutableArray new];
            }
            myMesageViewController.dataSouce=(NSMutableArray *)model.message;
            [self.navigationController pushViewController:myMesageViewController animated:YES];
        }];
        
    }
}
-(void)selectIndex:(NSInteger)index{

}
- (IBAction)pointAction:(id)sender {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.navigationController.navigationItem.leftBarButtonItem.title=@"首页";
        target.title=@"积分规则";
        target.urlString =@"http://www.bywindow.com/inf.php/Member/point_rule";
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
 
    
}
@end
