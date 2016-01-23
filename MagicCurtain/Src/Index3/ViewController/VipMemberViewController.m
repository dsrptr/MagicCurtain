//
//  VipMemberViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/28.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "VipMemberViewController.h"
#import "CourseViewController.h"
#import "RecodCell.h"
#import "IndexService.h"
#import "Index1Service.h"
#import "LessonDetailModel.h"
#import "ContentViewController.h"
#import "CaseInfoModel.h"
@interface VipMemberViewController ()
{
    IndexService *indexService;
    Index1Service *index1Service;
    LoginModel *user;
}

@end

@implementation VipMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的分享";
    self.tableView.tableFooterView=[UIView new];
    //    self.tableViewHeight.constant=DeviceFrame.size.height-64-110-44;    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lessonDataSouse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecodeDetailModel *model =self.lessonDataSouse[indexPath.row];
    RecodCell *cell =[tableView dequeueReusableCellWithIdentifier:@"RecodCell" forIndexPath:indexPath];
    cell.title.text=model.title;
    cell.typle.text=[NSString stringWithFormat:@"模块:%@",model.block_name];
    cell.regTime.text=[NSString stringWithFormat:@"分享时间:%@",model.reg_time];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 63;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecodeDetailModel *model =self.lessonDataSouse[indexPath.row];
    if ([model.block_type isEqualToString:@"1"]) {
        if (!indexService) {
            indexService =[IndexService new];
        }
        [indexService lessonInfoWithLesson_id:model.lesson_id
                                       andMid:user.mid
                                    andSecret:user.secret
                           withViewController:self
                                     withDone:^(LessonDetailModelInfo *models){
            LessonDetailInfoModelInfo *object=models.lesson;
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
            CourseViewController *courseViewController =[storyboard instantiateViewControllerWithIdentifier:@"CourseViewController"];
            courseViewController.models=object;
            [self.navigationController pushViewController:courseViewController animated:YES];
        }];
    }else{
        if (!index1Service) {
            index1Service=[Index1Service new];
        }
        [index1Service caseInfoWithLessonId:model.lesson_id
                                     andMid:user.mid
                                  andSecret:user.secret
                         withViewController:self
                                   withDone:^(CaseInfoModelInfo *models){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index1" bundle:nil];
            ContentViewController *contentViewController =[storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
            contentViewController.model=models.lesson;
            contentViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:contentViewController animated:YES];
        }];
    }
}

@end
