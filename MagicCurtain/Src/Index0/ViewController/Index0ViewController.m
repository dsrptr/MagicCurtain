//
//  ViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index0ViewController.h"
#import "UserNavigationController.h"
#import "FirstViewController.h"
#import "CourseViewController.h"
#import "MainTitleCell.h"
#import "CategoryCell.h"
#import "AdvertCell.h"
#import "TuijianKeCell.h"
#import "LatterCell.h"
#import "CateTitleCell.h"
#import "CateCell.h"
#import "CateNameCell.h"
#import "SeachViewController.h"
#import "IndexService.h"
#import "LessonIndexModel.h"
#import "KeyWordModel.h"
#import "PayNavigationViewController.h"
#import <UIImageView+WebCache.h>
#import "LessonDetailModel.h"
#import "LoginModel.h"
#import "MJRefresh.h"
#import "NSString+MT.h"
#import "MainTitleCell.h"
@interface Index0ViewController ()

{
    IndexService *indexService;
    NSMutableArray *lessonDataSouse;
    NSArray *lessonTypeSouse;
    LoginModel *user;
    MainTitleCell *selectTitleCell;
    NSInteger page;
    NSMutableArray *cellArray;
}

@end

@implementation Index0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"课程";
    page =1;
    cellArray=[NSMutableArray new];
    lessonDataSouse=[NSMutableArray new];
    indexService =[IndexService new];
    [SharedAction setupRefreshWithTableView:self.tableView1 toTarget:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserInfo) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginoutAction) name:@"LoginOut" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selcetLesonType:) name:@"selcetLesonType" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess:) name:@"PaySuccess" object:nil];
    self.allCateView.hidden=YES;
    self.cateTableHeight.constant=0;
    SharedData *sharedData =[SharedData sharedInstance];
    user =sharedData.user;
    [self getLessonIndexDataWithMid:user.mid andSercet:user.secret];
    [[NSUserDefaults standardUserDefaults] setObject:@"noStart" forKey:@"isStart"];
    self.tableView1.tableFooterView=[UIView new];
    self.tableView2.tableFooterView=[UIView new];    
}

-(void)paySuccess:(NSNotification*)noti{
    NSLog(@"%@",noti.userInfo);
    NSString *lessonType =noti.userInfo[@"lessonType"];
    NSString *lessonId=noti.userInfo[@"lessonId"];
    NSString *indexPath=noti.userInfo[@"indexPath"];
    SharedData *sharedData =[SharedData sharedInstance];
    if ([sharedData.index isEqualToString:@"2"]) {
        if ([lessonType isEqualToString:@"1"]) {
            LessonInfoModel *model =lessonDataSouse[[sharedData.indexPath integerValue]];
            if ([lessonId isEqualToString:model.lesson_id]) {
                model.is_pay=2;
                [lessonDataSouse replaceObjectAtIndex:[indexPath integerValue] withObject:model];
                [self.tableView1 reloadData];
            }
        }

    }
}

-(void)getUserInfo{
    SharedData *sharedData =[SharedData sharedInstance];
    user =sharedData.user;
}


-(void)loginoutAction{
    SharedData *sharedData =[SharedData sharedInstance];
    user =sharedData.user;
}


-(void)selcetLesonType:(NSNotification*)noti{
    self.index=[[noti.userInfo objectForKey:@"indexPath"] integerValue];
    self.lessonType=[noti.userInfo objectForKey:@"lesson_type"];
    [self.collectionView reloadData];
    [self headerRereshing];
}

-(void)getLessonIndexDataWithMid:(NSString *)mid andSercet:(NSString *)sercet{
    [indexService lessonIndexDataWithmid:mid andSecret:sercet andLesson_type:self.lessonType withViewController:self withDone:^(LessonIndexModelInfo *model){
        lessonDataSouse =(NSMutableArray *)model.lesson;
        lessonTypeSouse=model.lesson_type;
        [cellArray removeAllObjects];
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        return 1;
    }
    return lessonTypeSouse.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag==0) {
        return 2;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    NSInteger section=indexPath.section;
    if (tableView.tag==0) {
        LessonInfoModel *model =lessonDataSouse[section];
        CategoryCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        cell.title.text=model.title;
        cell.clicklike.text=[NSString stringWithFormat:@"%@人喜欢",model.click_like];
        [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
        cell.time.text=[NSString stringWithFormat:@"%@分钟",model.duration];
        cell.playNum.text=[NSString stringWithFormat:@"%@次",model.play_nums];
        if ([model.free_type isEqualToString:@"1"]) {
            cell.price.text=@"免费";
        }else {
            if (model.is_pay==2) {
                cell.price.text=[NSString stringWithFormat:@"¥%0.2f 已支付",model.money];
            }else{
                cell.price.text=[NSString stringWithFormat:@"¥%0.2f",model.money];
            }
        }
        if (model.is_collect==1) {
            [cell.addCollectAction setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
        }else{
            [cell.addCollectAction setImage:[UIImage imageNamed:@"iscollection.png"] forState:UIControlStateNormal];
        }
        return cell;
    }else{
        CateNameCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CateNameCell" forIndexPath:indexPath];
        if (self.index==row) {
            cell.selectView.hidden=NO;
        }else{
            cell.selectView.hidden=YES;
        }
        if (row==0) {
             cell.cateName.text=@"全部分类";
            return cell;
        }
        LessonTypeInfoModel *model =lessonTypeSouse[row-1];
        cell.cateName.text=model.name;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag==0) {
        return lessonDataSouse.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (tableView.tag==1) {
        return 40;
    }
        return 68;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section =indexPath.section;
    if (tableView.tag==0) {
         LessonInfoModel *model =lessonDataSouse[section];
        if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
            if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
                UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
                [self presentViewController:userNavi animated:YES completion:nil];
                return;
            }
            UIAlertController *alertViewcontroller=[UIAlertController alertControllerWithTitle:@"付费课程" message:[NSString stringWithFormat:@"当前课程为付费课程,需要购买后才能观看,本次课程需支付%0.2f元是否现在去支付",model.money]  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
                UIAlertAction*okAction= [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
                PayNavigationViewController *payNavi=[storyboard instantiateViewControllerWithIdentifier:@"PayNavigationViewController"];
                    payNavi.payMoney=[NSString stringWithFormat:@"%0.2f",model.money];
                    payNavi.lessonId=model.lesson_id;
                    payNavi.lessonType=@"1";
                    payNavi.indexPath=[NSString stringWithFormat:@"%ld",(long)section];
                    payNavi.lessonName=model.title;
                    SharedData *sharedData =[SharedData sharedInstance];
                    sharedData.index=@"2";
                    [self presentViewController:payNavi animated:YES completion:nil];
                }];
            [alertViewcontroller addAction:cancelAction];
            [alertViewcontroller addAction:okAction];
            [self presentViewController:alertViewcontroller animated:YES completion:nil];
            return;
        }
        [indexService lessonInfoWithLesson_id:model.lesson_id andMid:user.mid andSecret:user.secret withViewController:self withDone:^(LessonDetailModelInfo *models){
            LessonDetailInfoModelInfo *object=models.lesson;
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
            CourseViewController *courseViewController =[storyboard instantiateViewControllerWithIdentifier:@"CourseViewController"];
            courseViewController.models=object;
            courseViewController.picUrlString=model.picture;
            courseViewController.iscollect =model.is_collect;
            courseViewController.hidesBottomBarWhenPushed=YES;
            courseViewController.navigationController.navigationBar.hidden=YES;
            [self.navigationController pushViewController:courseViewController animated:YES];
        }];
    }else{
        self.index=indexPath.row;
        [self.collectionView reloadData];
        __block Index0ViewController *blockSelf =self;
        self.allCateView.hidden=YES;
        [UIView animateWithDuration:0.4 animations:^{
            self.cateTableHeight.constant=0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL completion){
            if (completion) {
                self.index=indexPath.row;
                if (self.index==0) {
                    self.lessonType=@"";
                }else{
                    LessonTypeInfoModel *model =lessonTypeSouse[self.index-1];
                    self.lessonType=model.lesson_type;
                }
                [blockSelf headerRereshing];
            }
        }];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[UIView new];
    return view;
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return lessonTypeSouse.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    MainTitleCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainTitleCell" forIndexPath:indexPath];
    if (row==0) {
        cell.title.text=@"全部分类";
        if (row==self.index) {
            cell.title.textColor=[SharedAction colorWithHexString:@"00B050"];
            cell.selectView.hidden=NO;
        }else{
            cell.title.textColor=[UIColor blackColor];
            cell.selectView.hidden=YES;
        }
        return cell;
    }
    LessonTypeInfoModel *model =lessonTypeSouse[row-1];
    cell.title.text=model.name;
    if (row==self.index) {
        cell.title.textColor=[SharedAction colorWithHexString:@"00B050"];
        cell.selectView.hidden=NO;
    }else{
        cell.title.textColor=[UIColor blackColor];
        cell.selectView.hidden=YES;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.index=indexPath.row;
    if (self.index==0) {
        self.lessonType=@"";
    }else{
        LessonTypeInfoModel *model =lessonTypeSouse[self.index-1];
        self.lessonType=model.lesson_type;
    }
    [self.collectionView reloadData];
    [self headerRereshing];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    if (row==0) {
        selectTitleCell.titleWidth.constant=[NSString widthWithString:@"全部分类" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8;
        selectTitleCell.selectWidth.constant=[NSString widthWithString:@"全部分类" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8;
        [self.view layoutIfNeeded];
        return CGSizeMake([NSString widthWithString:@"全部分类" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8, 23);
    }else{
    LessonTypeInfoModel *model =lessonTypeSouse[row-1];
//    return CGSizeMake(230, 23);
    selectTitleCell.titleWidth.constant=[NSString widthWithString:model.name font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8;
    selectTitleCell.selectWidth.constant=[NSString widthWithString:model.name font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8;
        [self.view layoutIfNeeded];
        return CGSizeMake([NSString widthWithString:model.name font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(240, 23)]+8, 23);
    }
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0  blue:238/255.0  alpha:1];
}

- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

-(void)pushToTargate:(NSNotification *)noti{
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    CourseViewController *courseViewController =[storyboard instantiateViewControllerWithIdentifier:@"CourseViewController"];
    courseViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:courseViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moreAction:(id)sender {
    self.allCateView.hidden=NO;
    [self.tableView2 reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        self.cateTableHeight.constant=DeviceFrame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-26;
//        [self.view layoutIfNeeded];
    }];
}

- (IBAction)seachAction:(id)sender {
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    SeachViewController *seachViewController =[storyboard instantiateViewControllerWithIdentifier:@"SeachViewController"];
    seachViewController.hidesBottomBarWhenPushed=YES;
    [indexService keywordListwithViewController:self WithDone:^(KeyWordModelInfo *model){
        seachViewController.dataSouce=model.keyword;
        seachViewController.seachType=1;
        [self.navigationController pushViewController:seachViewController animated:YES];
    }];
}
-(void)headerRereshing
{
    page =1;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [self getLessonDataWithMid:user.mid andSecret:user.secret andLessonType:self.lessonType andPage:pageString];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [self getLessonDataWithMid:user.mid andSecret:user.secret andLessonType:self.lessonType andPage:pageString];
}

-(void)getLessonDataWithMid:(NSString *)mid andSecret:(NSString *)secret andLessonType:(NSString *)lessonTypes andPage:(NSString *)pageString{
    [indexService typeLessonWithLesson_type:lessonTypes andMid:mid andPage:pageString andPage_size:@"20" andSecret:secret withViewController:self withDone:^(LessonIndexModelInfo *model){
        if ([pageString isEqualToString:@"1"]) {
             [lessonDataSouse removeAllObjects];
            lessonDataSouse =(NSMutableArray *)model.lesson;
            [self.tableView1 headerEndRefreshing];
        }else{
            [lessonDataSouse addObjectsFromArray:model.lesson];
            [self.tableView1 footerEndRefreshing];
        }
        [self.tableView1 reloadData];
    }];
}
@end
