//
//  ArreaViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ArreaViewController.h"
#import "Index3Service.h"
#import "ArreaCell.h"
#import "ArreaModel.h"
@interface ArreaViewController ()
{
    Index3Service *index3Service;
    LoginModel *user;
    SharedData *sharedData;
}
@end

@implementation ArreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    index3Service=[Index3Service new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArreaCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ArreaCell" forIndexPath:indexPath];
    if (self.getType==1) {
         ArreaModelProvinceInfo *model =self.nameArray[indexPath.row];
        
        cell.name.text=model.province_name;
    }else if (self.getType==2){
        ArreaModelCityInfo*model =self.nameArray[indexPath.row];
        cell.name.text=model.city_name;
    }else{
        ArreaModelAreaInfo*model =self.nameArray[indexPath.row];
        cell.name.text=model.area_name;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.getType==1) {
        ArreaModelProvinceInfo *models =self.nameArray[indexPath.row];
        sharedData.user.province_name=models.province_name;
        [index3Service memberProvinceWithMid:user.mid andSecret:user.secret andType:1 andKeyWord:models.province withViewController:self withDone:^(ArreaModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            ArreaViewController *arreaViewController=[storyboard instantiateViewControllerWithIdentifier:@"ArreaViewController"];
            arreaViewController.address=models.province_name;
            arreaViewController.nameArray=model.city;
            arreaViewController.getType=2;
            [self.navigationController pushViewController:arreaViewController animated:YES];
        }];
    }else if(self.getType==2){
        ArreaModelCityInfo *models =self.nameArray[indexPath.row];
        sharedData.user.city_name=models.city_name;
        [index3Service memberProvinceWithMid:user.mid andSecret:user.secret andType:2 andKeyWord:models.city withViewController:self withDone:^(ArreaModelInfo *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            ArreaViewController *arreaViewController=[storyboard instantiateViewControllerWithIdentifier:@"ArreaViewController"];
            arreaViewController.nameArray=model.area;
            arreaViewController.address=[NSString stringWithFormat:@"%@ %@", self.address,models.city_name];
            arreaViewController.getType=3;
            [self.navigationController pushViewController:arreaViewController animated:YES];
        }];
    }else{
        ArreaModelAreaInfo *model =self.nameArray[indexPath.row];
        sharedData.user.area_name=model.area_name;
        self.address=[NSString stringWithFormat:@"%@ %@", self.address,model.area_name];
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:model.area,@"areaId",self.address,@"arreaAddress",nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"getArrea" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
//        NSLog(@"dd");
    }
    
    
}
@end
