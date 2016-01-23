//
//  Index1ViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index1ViewController.h"
#import "ContentViewController.h"
#import "UserNavigationController.h"
#import "PayNavigationViewController.h"
#import "IndexService.h"
#import "SeachViewController.h"
#import "AnliDetailCell.h"
#import "LessonIndexModel.h"
#import "Index1Service.h"
#import "CaseInfoModel.h"
#import "KeyWordModel.h"
#import "MJRefresh.h"
#import <UIImageView+WebCache.h>
@interface Index1ViewController ()
{
    Index1Service *index1service;
    IndexService *indexService;
    LoginModel *user;
    NSInteger page;
    NSMutableArray *dataSouce;
}
@end

@implementation Index1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"案例";
    page=1;
    dataSouce =[NSMutableArray new];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    index1service=[Index1Service new];
    indexService=[IndexService new];
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserInfo) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess:) name:@"PaySuccess" object:nil];
    [self headerRereshing];
    self.tableView.tableFooterView=[UIView new];
}

-(void)paySuccess:(NSNotification*)noti{
    NSLog(@"%@",noti.userInfo);
    NSString *lessonType =noti.userInfo[@"lessonType"];
    NSString *lessonId=noti.userInfo[@"lessonId"];
    NSString *indexPath=noti.userInfo[@"indexPath"];
    SharedData *sharedDatas =[SharedData sharedInstance];
    if ([sharedDatas.index isEqualToString:@"3"]) {
        if ([lessonType isEqualToString:@"2"]) {
            LessonInfoModel *model =dataSouce[[indexPath integerValue]];
            if ([lessonId isEqualToString:model.lesson_id]) {
                model.is_pay=2;
                [dataSouce replaceObjectAtIndex:[indexPath integerValue] withObject:model];
                [self.tableView reloadData];
            }
        }
    }
}
-(void)getUserInfo{
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonInfoModel *model =dataSouce[indexPath.row];
    AnliDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AnliDetailCell" forIndexPath:indexPath];
    cell.title.text=model.title;
    cell.demo.text=model.demo;
    cell.playNum.text=model.play_nums;
    if ([model.free_type isEqualToString:@"2"]||model.free_type==nil) {
        if (model.is_pay==1) {
            cell.money.text=[NSString stringWithFormat:@"¥:%0.2f",model.money];
        }else{
            cell.money.text=[NSString stringWithFormat:@"¥:%0.2f 已支付",model.money];
        }
    }else {
        cell.money.text=[NSString stringWithFormat:@"免费"];
    }
    if (model.is_collect==2) {
        [cell.collect setImage:[UIImage imageNamed:@"iscollection"] forState:UIControlStateNormal];
    }else{
        [cell.collect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 73;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     LessonInfoModel *model =dataSouce[indexPath.row];
    if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
        if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
            UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
            [self presentViewController:userNavi animated:YES completion:nil];
        }
        UIAlertController *alertViewcontroller=[UIAlertController alertControllerWithTitle:@"付费案例" message:[NSString stringWithFormat:@"当前案例为付费案例,需要购买后才能观看,本次课程需支付%0.2f元是否现在去支付",model.money]  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        UIAlertAction*okAction= [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
            PayNavigationViewController *payNavi=[storyboard instantiateViewControllerWithIdentifier:@"PayNavigationViewController"];
            payNavi.payMoney=[NSString stringWithFormat:@"%0.2f",model.money];
            payNavi.lessonId=model.lesson_id;
            payNavi.lessonType=@"2";
            SharedData *sharedData =[SharedData sharedInstance];
            sharedData.lessonId=model.lesson_id;
            sharedData.lessonType=@"2";
            payNavi.lessonName=model.title;
            sharedData.indexPath=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            sharedData.index=@"3";
            [self presentViewController:payNavi animated:YES completion:nil];
        }];
        [alertViewcontroller addAction:cancelAction];
        [alertViewcontroller addAction:okAction];
        [self presentViewController:alertViewcontroller animated:YES completion:nil];
        return;
    }
    [index1service caseInfoWithLessonId:model.lesson_id
                                 andMid:user.mid
                              andSecret:user.secret
                     withViewController:self
                               withDone:^(CaseInfoModelInfo *models){
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index1" bundle:nil];
        ContentViewController *contentViewController =[storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
        contentViewController.model=models.lesson;
        contentViewController.demo=model.demo;
        if (!contentViewController.dataSouce) {
            contentViewController.dataSouce=[[NSMutableArray alloc] initWithArray:contentViewController.model.lesson_message];
        }else{
            contentViewController.dataSouce=(NSMutableArray*)contentViewController.model.lesson_message;
        }
        contentViewController.lessonid=model.lesson_id;
        contentViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:contentViewController animated:YES];
    }];
}


- (IBAction)seachAction:(id)sender {
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    SeachViewController *seachViewController =[storyboard instantiateViewControllerWithIdentifier:@"SeachViewController"];
    seachViewController.hidesBottomBarWhenPushed=YES;
    seachViewController.seachType=2;
    [indexService keywordListwithViewController:self WithDone:^(KeyWordModelInfo *model){
        seachViewController.dataSouce=model.keyword;
        [self.navigationController pushViewController:seachViewController animated:YES];
    }];
}
-(void)getCaseDataWithMid:(NSString *)mid andSecret:(NSString *)secret andPage:(NSString *)pageString andPageSize:(NSString *)pageSize{
    [index1service caseListWithMid:mid
                         andSecret:secret
                           andPage:pageString
                       andPageSize:pageSize
                withViewController:self
                          withDone:^(LessonIndexModelInfo *model){
        if ([pageString isEqualToString:@"1"]) {
            dataSouce =(NSMutableArray*)model.lesson;
            [self.tableView headerEndRefreshing];
        }else {
            [dataSouce addObjectsFromArray:model.lesson];
            [self.tableView footerEndRefreshing];
        }
        [self.tableView reloadData];
    }];
}

-(void)headerRereshing
{
    [dataSouce removeAllObjects];
    page =1;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [self getCaseDataWithMid:user.mid andSecret:user.secret andPage:pageString andPageSize:@"20"];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [self getCaseDataWithMid:user.mid andSecret:user.secret andPage:pageString andPageSize:@"20"];
}
@end
