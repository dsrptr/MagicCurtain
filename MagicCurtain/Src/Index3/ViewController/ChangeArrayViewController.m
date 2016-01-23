//
//  ChangeArrayViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ChangeArrayViewController.h"
#import "Index3Service.h"
#import "ArreaViewController.h"
#import "ArreaModel.h"
@interface ChangeArrayViewController ()
{
    Index3Service *index3Service;
    LoginModel *user;
    SharedData *sharedData;
    NSString *arreaid;
}
@end

@implementation ChangeArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index3Service =[Index3Service new];
    sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    arreaid=[NSString stringWithFormat:@"%ld",(long)user.area];
    if (![user.province_name isEqualToString:@""]) {
        NSString *place=[NSString stringWithFormat:@"%@ %@ %@",user.province_name,user.city_name,user.area_name];
        [self.arreaPlace setTitle:place forState:UIControlStateNormal];
        self.name.text=user.address;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getArrea:) name:@"getArrea" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.name.text=@"";
}

-(void)getArrea:(NSNotification *)noti{
    arreaid=noti.userInfo[@"areaId"];
    [self.arreaPlace setTitle:noti.userInfo[@"arreaAddress"] forState:UIControlStateNormal];
}

- (IBAction)chooseAction:(id)sender {
    [index3Service memberProvinceWithMid:user.mid andSecret:user.secret andType:0 andKeyWord:@"" withViewController:self withDone:^(ArreaModelInfo *model){
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        ArreaViewController *arreaViewController=[storyboard instantiateViewControllerWithIdentifier:@"ArreaViewController"];
        arreaViewController.nameArray=model.province;
        arreaViewController.getType=1;
        arreaViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:arreaViewController animated:YES];
    }];
}
- (IBAction)postAction:(id)sender {
    [index3Service memberAddressWithMid:user.mid andSecret:user.secret andAddress:self.myTextView.text andAreaId:arreaid withViewController:self withDone:^(id model){
        sharedData.user.address=self.myTextView.text;
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }];
}
@end
