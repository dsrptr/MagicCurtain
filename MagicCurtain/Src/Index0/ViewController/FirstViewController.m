//
//  FirstViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/6.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "FirstViewController.h"
#import "RootTabBarController.h"
#import "CourseViewController.h"
#import <UIImageView+WebCache.h>
#import "PayNavigationViewController.h"
#import "UserNavigationController.h"
#import "PushHistoryViewController.h"
#import "WebViewController.h"
#import "AdvertCell.h"
#import "TuijianKeCell.h"
#import "LatterCell.h"
#import "CateTitleCell.h"
#import "CateCell.h"
#import "IndexModel.h"
#import "IndexService.h"
#import "LessonIndexModel.h"
#import "StatusModel.h"
#import "PushListModel.h"
#import "SeachViewController.h"
#import "KeyWordModel.h"

//#import "AdvertInfo"
@interface FirstViewController ()<MartinLiPageScrollViewDelegate>
{
    IndexService *indexService;
    CateTitleCell *cateCell;
    SharedData  *sharedData;
    LoginModel *user;
    NSArray *dataSouce;
    NSArray *pictureArray;
    NSArray *lessonTypeArray;
    NSMutableArray *lessonNewArray;
    NSArray *lessonFreeArray;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    indexService=[IndexService new];
    lessonNewArray=[NSMutableArray new];
    self.tableView.tableFooterView=[UIView new];
   [[NSUserDefaults standardUserDefaults] setObject:@"start" forKey:@"isStart"];
    self.title=@"摆布学院";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getIndexDataWithLoginModel) name:@"LoginSuccess" object:nil];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paySuccess:) name:@"PaySuccess" object:nil];
    [self getIndexDataWithLoginModel];
    // Do any additional setup after loading the view.
}

-(void)getIndexDataWithLoginModel{
    sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    [indexService indexWithMid:user.mid andSecret:user.secret withViewController:self withDone:^(IndexModelInfo *model){
        pictureArray =model.advert;
        lessonTypeArray=model.lesson_type;
        lessonNewArray=(NSMutableArray*)model.lesson_new;
        [cateCell.collcetionView reloadData];
        [self.tableView reloadData];
    }];
}
-(void)paySuccess:(NSNotification*)noti{
    NSLog(@"%@",noti.userInfo);
    NSString *lessonType =noti.userInfo[@"lessonType"];
    NSString *lessonId=noti.userInfo[@"lessonId"];
    NSString *indexPath=noti.userInfo[@"indexPath"];
    SharedData *sharedDatas =[SharedData sharedInstance];
    if ([sharedDatas.index isEqualToString:@"1"]) {
        if ([lessonType isEqualToString:@"1"]) {
            Lesson_newInfo *model =lessonNewArray[[indexPath integerValue]];
            if ([lessonId isEqualToString:model.lesson_id]) {
                model.is_pay=2;
                [lessonNewArray replaceObjectAtIndex:[indexPath integerValue] withObject:model];
                [self.tableView reloadData];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return lessonNewArray.count;
    }
    if(section==5){
        return lessonFreeArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section =indexPath.section;
        if (section==0) {
            AdvertCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AdvertCell" forIndexPath:indexPath];
            cell.pageView.imageType = UIImageUrlType;
            cell.pageView.imgUrls =[self namesFromPictures:pictureArray];
            cell.pageView.titles =[self titlesFromPictures:pictureArray];
            cell.pageView.urls = [self urlsFromPictures:pictureArray];
            cell.pageView.martinLiPageScrollViewDelegate = self;
            cell.pageView.isAutoScroll = YES;
            cell.pageView.titleIsHidden = YES;//默认为NO（可选）
            cell.pageView.height = cell.pageViewHeight.constant;
            cell.pageView.pageViewType = MLPageScrollViewAdvertiseMode;//默认是广告模式（可选）
            cell.pageView.timeInterval = 4;//默认自动滚动图片时间为2秒（可选）
            [cell.pageView updatePageViewInFatherController:self];
            cell.pageView.defaultLocationIndex = 1;//这一步必须放在最后。（可选）
            return cell;
        }else if(section==1){
            CateTitleCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CateTitleCell" forIndexPath:indexPath];
            cateCell=cell;
            return cell;
        }else if (section==2){
            LatterCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LatterCell" forIndexPath:indexPath];
            cell.title.text=@"最新课程";
            return cell;
        }else if(section==3){
            TuijianKeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TuijianKeCell" forIndexPath:indexPath];
            Lesson_newInfo *model=lessonNewArray[indexPath.row];
            cell.likeNumbs.text=[NSString stringWithFormat:@"%@人喜欢",model.click_like];
            cell.name.text=model.title;
            cell.time.text=[NSString stringWithFormat:@"课时:%@",model.duration];
            if (model.is_collect ==1 ) {
                [cell.iscollect setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
            }else{
                [cell.iscollect setImage:[UIImage imageNamed:@"iscollection.png"] forState:UIControlStateNormal];
            }
            if ([model.free_type isEqualToString:@"1"]) {
                cell.point.text=@"免费";
            }else {
                if (model.is_pay==2) {
                    cell.point.text=[NSString stringWithFormat:@"¥%0.2f 已支付",model.money];
                }else{
                    cell.point.text=[NSString stringWithFormat:@"¥%0.2f",model.money];
                }
            }
            [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
            cell.paly_nums.text=model.paly_nums;
            return cell;
        }else if(section==4){
            LatterCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LatterCell" forIndexPath:indexPath];
            cell.title.text=@"免费课程";
            return cell;
        }else{
            TuijianKeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TuijianKeCell" forIndexPath:indexPath];
            Lesson_newInfo *model=lessonFreeArray[indexPath.row];
            cell.name.text=model.title;
            cell.time.text=[NSString stringWithFormat:@"课时:%@",model.duration];
            if (model.is_collect ==1 ) {
                [cell.iscollect setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
            }else{
                [cell.iscollect setImage:[UIImage imageNamed:@"iscollection.png"] forState:UIControlStateNormal];
            }
            if ([model.free_type isEqualToString:@"1"]) {
                cell.point.text=@"免费";
            }else {
                if (model.is_pay==2) {
                    cell.point.text=[NSString stringWithFormat:@"¥%0.2f 已支付",model.money];
                }
                cell.point.text=[NSString stringWithFormat:@"¥%0.2f",model.money];
            }
            [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
            cell.paly_nums.text=model.paly_nums;
            return cell;
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
        if (indexPath.section==0) {
            return 160;
        }else if(indexPath.section==1){
            if (lessonTypeArray.count%2==0) {
                return lessonTypeArray.count/2* 33+8;
            }else{
                return (lessonTypeArray.count/2+1)* 33+8;
            }
           
        }else if (indexPath.section==2){
            return 26;
        }else{
            return 69;
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        LessonInfoModel *model =lessonNewArray[indexPath.row];
        if ([model.free_type isEqualToString:@"2"]&&model.is_pay==1) {
            if (user.mid==nil||[user.mid isEqualToString:@""]||user.secret==nil||[user.secret isEqualToString:@""]) {
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
                UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
                [self presentViewController:userNavi animated:YES completion:nil];
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
                sharedData.index=@"1";
                
                [self presentViewController:payNavi animated:YES completion:nil];
            }];
            [alertViewcontroller addAction:cancelAction];
            [alertViewcontroller addAction:okAction];
            [self presentViewController:alertViewcontroller animated:YES completion:nil];
            return;
        }
//
        [indexService lessonInfoWithLesson_id:model.lesson_id andMid:user.mid andSecret:user.secret withViewController:self withDone:^(LessonDetailModelInfo *models){
            LessonDetailInfoModelInfo *object=models.lesson;
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
            CourseViewController *courseViewController =[storyboard instantiateViewControllerWithIdentifier:@"CourseViewController"];
            courseViewController.models=object;
            courseViewController.picUrlString=model.picture;
            courseViewController.iscollect =model.is_collect;
            courseViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:courseViewController animated:YES];
        }];
    }
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return lessonTypeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CateCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CateCell" forIndexPath:indexPath];
    Lesson_typeInfo *model=lessonTypeArray[indexPath.row];
    cell.layer.borderColor=[SharedAction colorWithHexString:@"dddddd"].CGColor;
    cell.cateName.text=model.name;
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:nil];
    cell.layer.borderWidth=0.5;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Lesson_typeInfo *model=lessonTypeArray[indexPath.row];
    RootTabBarController *index0Nav = self.tabBarController;
    [index0Nav setIndex:indexPath.row+1 andLessonType:model.lesson_type];
    
    self.tabBarController.selectedIndex=1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (DeviceFrame.size.height>568) {
         return CGSizeMake((DeviceFrame.size.width-18-16)/2, 35);
    }
    return CGSizeMake((DeviceFrame.size.width-18)/2, 35);
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0  blue:238/255.0  alpha:1];
}

- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}
//从数组中添加图片
-(NSArray *)namesFromPictures:(NSArray *)pictures{
    if (pictures) {
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            AdvertInfo *models = pictures[i];
            NSString *name = models.picture;
            [names addObject:name];
        }
        return names;
    }else{
        return nil;
    }
}
//从数组中标题
-(NSArray *)titlesFromPictures:(NSArray *)pictures{
    if (pictures) {
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            AdvertInfo *picture = pictures[i];
            NSString *title = nil;
            if (picture.title!=nil) {
                title = picture.title;
            }else{
                title = @"";
            }
            [titles addObject:title];
        }
        return titles;
    }else{
        return nil;
    }
}
//从数组中添加链接
-(NSArray *)urlsFromPictures:(NSArray *)pictures{
    if (pictures) {
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (int i=0; i<pictures.count; i++) {
            AdvertInfo *picture = pictures[i];
            NSString *url = nil;
            if (picture.advert_url!=nil) {
                url = picture.advert_url;
            }else{
                url = @"";
            }
            [urls addObject:url];
        }
        return urls;
    }else{
        return nil;
    }
}
-(void)imgViewDidTouchActionAtIndex:(NSInteger)index inUrlArray:(NSArray *)urlArray andTitleArray:(NSArray *)titleArray{
    NSString *url = urlArray[index];
    NSString *title=titleArray[index];
    if ([url  hasPrefix:@"http"]) {
        WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
        target.navigationController.navigationItem.leftBarButtonItem.title=@"首页";
        target.title=title;
        target.urlString = url;
        target.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:target animated:YES];
    }else{
        NSLog(@"第%ld张图片暂无url",(long)index);
    }
}

-(void)panInViewControllerWithType:(BOOL)type{

}

- (IBAction)messageAction:(id)sender {
       UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index4" bundle:nil];
      PushHistoryViewController *pushHistoryViewController =[storyboard instantiateViewControllerWithIdentifier:@"PushHistoryViewController"];
    pushHistoryViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pushHistoryViewController animated:YES];
  
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
@end
