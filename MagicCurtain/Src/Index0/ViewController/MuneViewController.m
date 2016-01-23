//
//  MuneViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "MuneViewController.h"
#import "MuneCell.h"
@interface MuneViewController ()

@end

@implementation MuneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectnextINview) name:@"next" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectlastINview) name:@"last" object:nil];
    if (self.dataSouce.count>0) {
        LessonSubInfoModelInfo *model =self.dataSouce[0];
        [self.delegate palyVideoWithIndex:0 andUrl:model.video_url];
    }else{
    }
    self.tableView.tableFooterView=[UIView new];
    self.tableViewHeight.constant=DeviceFrame.size.height-177-47;
    [self.view layoutIfNeeded];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonSubInfoModelInfo *model =self.dataSouce[indexPath.row];
    MuneCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MuneCell" forIndexPath:indexPath];
    if (indexPath.row%2==1) {
        cell.contentView.backgroundColor=[SharedAction colorWithHexString:@"#F8F8F8"];
    }
    if(self.selectIndex==indexPath.row){
        cell.selectView.hidden=NO;
    }else{
        cell.selectView.hidden=YES;
    }
    cell.titleName.text=model.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex=indexPath.row;
     LessonSubInfoModelInfo *model =self.dataSouce[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [self.tableView reloadData];
    [self.delegate palyVideoWithIndex:indexPath.row andUrl:model.video_url];
   
}
-(void)selectnextINview{
    self.selectIndex=self.selectIndex+1;
     [self.tableView reloadData];
}
-(void)selectlastINview{
    self.selectIndex=self.selectIndex-1;
     [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
