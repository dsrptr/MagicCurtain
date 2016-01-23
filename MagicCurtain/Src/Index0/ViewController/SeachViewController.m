//
//  SeachViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "SeachViewController.h"
#import "IndexService.h"
#import "CategoryCell.h"
#import "LessonIndexModel.h"
#import "CourseViewController.h"
#import "ContentViewController.h"
#import "SKTag.h"
#import "SKTagButton.h"
#import "SKTagView.h"
#import <Masonry/Masonry.h>
#import <HexColors/HexColors.h>
#import <UIImageView+WebCache.h>
#import "PayNavigationViewController.h"
#import "UserNavigationController.h"
#import "AnliDetailCell.h"
#import "Index1Service.h"
#import "SeachResultModel.h"
@interface SeachViewController ()
{
    NSArray  *labelArray;
    IndexService *indexService;
    Index1Service *index1service;
    LoginModel *user;
    NSMutableArray *lessonData;
    //标签是否出现  1为出现 0为不出现；
    int k;
}
@property (strong, nonatomic) SKTagView *tagView;
@property (nonatomic, strong) NSArray *colorPool;
@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"热门搜索";
    labelArray=self.dataSouce;
     indexService=[[IndexService alloc] init];
    index1service=[Index1Service new];
    lessonData =[[NSMutableArray alloc] init];
    [self setupTagView];
     self.tableView.hidden=YES;
    SharedData *sharedData =[SharedData sharedInstance];
    user =sharedData.user;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    labelArray=;
    self.tableView.tableFooterView=[UIView new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess:) name:@"PaySuccess" object:nil];
    // Do any additional setup after loading the view.
}

-(void)paySuccess:(NSNotification*)noti{
    NSString *lessonType =noti.userInfo[@"lessonType"];
    NSString *lessonId=noti.userInfo[@"lessonId"];
    NSString *indexPath=noti.userInfo[@"indexPath"];
    SharedData *sharedDatas =[SharedData sharedInstance];
    if ([sharedDatas.index isEqualToString:@"5"]) {
//        if ([lessonType isEqualToString:@"1"]) {
            LessonInfoModel *model  =self.dataSouce[[indexPath integerValue]];
            if ([lessonId isEqualToString:model.lesson_id]) {
                model.is_pay=2;
                [lessonData replaceObjectAtIndex:[indexPath integerValue] withObject:model];
                [self.tableView reloadData];
            }
//        }else{
//        
//        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.seachType==1) {
        return 1;
    }else{
        return lessonData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.seachType==1) {
        return 2;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.seachType==1) {
        return lessonData.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section =indexPath.section;
    NSInteger row=indexPath.row;
    if (self.seachType==1) {
        LessonInfoModel *model =lessonData[section];
        CategoryCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
        cell.title.text=model.title;
        [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
        cell.time.text=[NSString stringWithFormat:@"%@分钟",model.duration];
        cell.clicklike.text=model.click_like;
        cell.playNum.text=[NSString stringWithFormat:@"%@次",model.play_nums];
        if ([model.free_type isEqualToString:@"1"]) {
            cell.price.text=@"免费";
        }else {
            if (model.is_pay==2) {
                cell.price.text=[NSString stringWithFormat:@"¥%0.2f已支付",model.money];
            }
            cell.price.text=[NSString stringWithFormat:@"¥%0.2f",model.money];
        }
        if (model.is_collect==1) {
            [cell.addCollectAction setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
        }else{
            [cell.addCollectAction setImage:[UIImage imageNamed:@"iscollection.png"] forState:UIControlStateNormal];
        }
        return cell;
    }else{
        LessonInfoModel *model =lessonData[indexPath.row];
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (self.seachType==1) {
        return 68;
    }else{
        return 81;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.seachType==1) {
        LessonInfoModel *model =lessonData[indexPath.section];
        if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
            if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
                UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
                [self presentViewController:userNavi animated:YES completion:nil];
                return;
            }
            UIAlertController *alertViewcontroller=[UIAlertController alertControllerWithTitle:@"付费课程" message:[NSString stringWithFormat:@"当前课程为付费课程,需要购买后才能观看,本次课程需支付%0.2f是否现在去支付",model.money]  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            UIAlertAction*okAction= [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
                PayNavigationViewController *payNavi=[storyboard instantiateViewControllerWithIdentifier:@"PayNavigationViewController"];
                payNavi.payMoney=[NSString stringWithFormat:@"%0.2f",model.money];
                payNavi.lessonId=model.lesson_id;
                payNavi.lessonType=@"1";
                payNavi.indexPath=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
                payNavi.lessonName=model.title;
                SharedData *sharedData =[SharedData sharedInstance];
                sharedData.index=@"5";

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
            courseViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:courseViewController animated:YES];
        }];
    }else{
        LessonInfoModel *model =lessonData[indexPath.row];
        if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
            if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
                UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
                [self presentViewController:userNavi animated:YES completion:nil];
            }
            UIAlertController *alertViewcontroller=[UIAlertController alertControllerWithTitle:@"付费案例" message:[NSString stringWithFormat:@"当前案例为付费案例,需要购买后才能观看,本次课程需支付%0.2f是否现在去支付",model.money]  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            }];
            UIAlertAction*okAction= [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
                PayNavigationViewController *payNavi=[storyboard instantiateViewControllerWithIdentifier:@"PayNavigationViewController"];
                payNavi.payMoney=[NSString stringWithFormat:@"%0.2f",model.money];
                payNavi.lessonId=model.lesson_id;
                payNavi.lessonType=@"2";
                payNavi.indexPath=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
                payNavi.lessonName=model.title;
                SharedData *sharedData =[SharedData sharedInstance];
                sharedData.index=@"5";
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
            contentViewController.dataSouce =contentViewController.model.lesson_message;
            contentViewController.lessonid=model.lesson_id;
            contentViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:contentViewController animated:YES];
        }];
    }
}


- (void)setupTagView
{
    SKTagView *view;
    self.tagView = ({
        view = [SKTagView new];
        view.backgroundColor = [UIColor clearColor];
        view.padding    = UIEdgeInsetsMake(16, 12, 6, 6);
        view.insets    = 8;
        view.lineSpace = 10;
        view;
    });
    [self.view addSubview:self.tagView];
    [labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         SKTag *tag = [SKTag tagWithText:obj];
         tag.textColor = [UIColor blackColor];
         tag.bgColor = [SharedAction colorWithHexString:@"E6E8E9"];
         tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
         tag.target = self;
         tag.action = @selector(handleBtn:);
         tag.cornerRadius = 2;
         [self.tagView addTag:tag];
     }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        make.centerY.equalTo(superView.mas_centerY).mas_offset(-130);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
}

- (void)handleBtn:(SKTagButton *)btn
{
    if (self.seachType==1) {
        [indexService lessonSearchwithKeyword:btn.titleLabel.text andBlock_type:@"1" andMid:user.mid andSerct:user.secret withViewController:self withDone:^(SeachResultModel *model){
            self.tableView.hidden=NO;
            self.tagView.hidden=YES;
            SeachResultModelInfo *models =model.info;
            [lessonData addObjectsFromArray:models.lesson];
            [self.tableView reloadData];
        }];
    }else{
        [indexService lessonSearchwithKeyword:btn.titleLabel.text andBlock_type:@"2" andMid:user.mid andSerct:user.secret withViewController:self withDone:^(SeachResultModel *model){
            self.tableView.hidden=NO;
            self.tagView.hidden=YES;
            SeachResultModelInfo *models =model.info;
            [lessonData addObjectsFromArray:models.cases];
            [self.tableView reloadData];
        }];
    }
}

- (IBAction)seachAgain:(id)sender {
    [lessonData removeAllObjects];
    self.tableView.hidden=YES;
    self.tagView.hidden=NO;
}
@end
