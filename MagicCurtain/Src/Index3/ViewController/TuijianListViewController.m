//
//  TuijianListViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "TuijianListViewController.h"
#import "TuiJianRenCell.h"
#import "MJRefresh.h"
#import "Index3Service.h"

@interface TuijianListViewController ()
{
    NSInteger page;
    LoginModel *user;
    Index3Service *idnex3Service;
}
@end

@implementation TuijianListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    idnex3Service =[Index3Service new];
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.tableView.tableFooterView=[UIView new];
    [SharedAction setupRefreshWithTableView:self.tableView toTarget:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    RefModelMemeberInfo *model =self.dataSouce[row];
    TuiJianRenCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TuiJianRenCell" forIndexPath:indexPath];
    if ([model.real_nam isEqualToString:@""]||model.real_nam==nil) {
        cell.name.text=model.mobile;
    }else {
        cell.name.text=model.real_nam;
    }
    cell.regTime.text= model.reg_time;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)headerRereshing
{
    page =1;
    [self.dataSouce removeAllObjects];
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
    [self getDataSouceWithPage:pageString andType:1];
}

- (void)footerRereshing
{
    page++;
    NSString *pageString =[NSString stringWithFormat:@"%ld",(long)page];
     [self getDataSouceWithPage:pageString andType:2];
}

-(void)getDataSouceWithPage:(NSString *)pageString
                    andType:(NSInteger)type{
    [idnex3Service memberRefWithMid:user.mid andSecret:user.secret andPage:pageString andPageSize:@"20" withViewController:self withDone:^(RefModelInfo *model){
        if (type==1) {
            self.dataSouce =(NSMutableArray *)model.memeber;
        }else{
            [self.dataSouce addObjectsFromArray:model.memeber];
        }
    }];
}

@end
