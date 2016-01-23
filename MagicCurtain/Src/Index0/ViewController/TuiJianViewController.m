//
//  TuiJianViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "TuiJianViewController.h"
#import "CategoryCell.h"
#import "LessonDetailModel.h"
#import <UIImageView+WebCache.h>
#import "PayNavigationViewController.h"
#import "UserNavigationController.h"
@interface TuiJianViewController ()
{
    LoginModel *user;
}
@end

@implementation TuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeight.constant=DeviceFrame.size.height-177-47-38;
    [self.view layoutIfNeeded];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    if (self.dataSouce ==nil) {
        self.dataSouce =[NSMutableArray new];
    }
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess:) name:@"PaySuccess" object:nil];
    // Do any additional setup after loading the view.
}

-(void)paySuccess:(NSNotification*)noti{
    NSString *lessonType =noti.userInfo[@"lessonType"];
    NSString *lessonId=noti.userInfo[@"lessonId"];
    NSString *indexPath=noti.userInfo[@"indexPath"];
    SharedData *sharedDatas =[SharedData sharedInstance];
    if ([sharedDatas.index isEqualToString:@"4"]) {
        if ([lessonType isEqualToString:@"1"]) {
            LessonWithInfoModelInfo *model  =self.dataSouce[[indexPath integerValue]];
            if ([lessonId isEqualToString:model.lesson_id]) {
                model.is_pay=2;
                [self.dataSouce replaceObjectAtIndex:[indexPath integerValue] withObject:model];
                [self.tableView reloadData];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonWithInfoModelInfo *model= self.dataSouce[indexPath.row];
    CategoryCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.title.text=model.title;
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    cell.time.text=[NSString stringWithFormat:@"%@分钟",model.duration];
    cell.playNum.text=[NSString stringWithFormat:@"%@次",model.play_nums];
    cell.clicklike.text=[NSString stringWithFormat:@"%@ 人喜欢",model.click_like];
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

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LessonWithInfoModelInfo *model= self.dataSouce[indexPath.row];
    if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
        if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
            UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
            [self presentViewController:userNavi animated:YES completion:nil];
            self.botton.constant=27;
            [self.view layoutIfNeeded];
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
            payNavi.indexPath=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
            payNavi.lessonName=model.title;
            SharedData *sharedData =[SharedData sharedInstance];
            sharedData.index=@"4";
            self.botton.constant=27;
            [self.view layoutIfNeeded];
            [self presentViewController:payNavi animated:YES completion:nil];
        }];
        [alertViewcontroller addAction:cancelAction];
        [alertViewcontroller addAction:okAction];
        [self presentViewController:alertViewcontroller animated:YES completion:nil];
        return;
    }
        [self.delegate playCoursWithLessonId:model.lesson_id withPicture:model.picture];
}


@end
