//
//  AuthenticationViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "TakePhotoViewController.h"
#import "Index3Service.h"
#import "StatusModel.h"
#import <UIImageView+WebCache.h>
@interface AuthenticationViewController ()
{
    LoginModel *user;
    Index3Service *index3Service;
}
@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index3Service=[Index3Service new];
    SharedData *sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.head_image] placeholderImage:nil];
    UIView *views =[[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceFrame.size.width, 22)];
    views.backgroundColor=[SharedAction colorWithHexString:@"4FC792"];
    [self.view addSubview:views];
    [self loadUserData];
}

-(void)loadUserData{
    if (user.member_audit==1) {
        [self.authTitle setTitle:@"尚未进行实名认证" forState:UIControlStateNormal];
    }else if(user.member_audit==2){
        [self.authTitle setTitle:@"正在等待平台审核" forState:UIControlStateNormal];
        self.startAuth.hidden=YES;
//        [self.startAuth setTitle:@"" forState:UIControlStateNormal];
    }else{
        [self.authTitle setTitle:@"实名认证通过" forState:UIControlStateNormal];
        self.startAuth.hidden=YES;
    }
    
    self.authenName.text=[NSString stringWithFormat:@"认证人:  %@",user.real_name];
    if ([user.real_name isEqualToString:@""]||user.real_name==nil) {
        self.realname.hidden=YES;
        self.idcade.hidden=YES;
        self.shoopname.hidden=YES;
    }else{
        self.realname.text=user.real_name;
        self.idcade.text=user.card_no;
        self.shoopname.text=user.store_name;
        self.realName.hidden=YES;
        self.idCade.hidden=YES;
        self.shoopName.hidden=YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAuthentication:(id)sender {
    if ((user.member_audit==1)&[user.real_name isEqualToString:@""]) {
        if ([self.realName.text isEqualToString:@""]||self.realName.text==nil||[self.idCade.text isEqualToString:@""]||self.idCade.text==nil||[self.shoopName.text isEqualToString:@""]||self.shoopName.text==nil) {
            [SVProgressHUD showErrorWithStatus:@"请填写完整的资料"];
            return;
        }else if(self.idCade.text.length!=18){
            [SVProgressHUD showErrorWithStatus:@"请填写正确的身份证号码!"];
            return;
        }
        [index3Service memberAuditWithMid:user.mid andSercet:user.secret andRealName:self.realName.text andCardNo:self.idCade.text andCardImage:nil andStoreName:self.shoopName.text andStoreImage:nil withViewController:self withDone:^(StatusModel *model){
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
            TakePhotoViewController *takePhotoViewController=[storyboard instantiateViewControllerWithIdentifier:@"TakePhotoViewController"];
            takePhotoViewController.hidesBottomBarWhenPushed=YES;
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            [self.navigationController pushViewController:takePhotoViewController animated:YES];
        }];
    }else {
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
        TakePhotoViewController *takePhotoViewController=[storyboard instantiateViewControllerWithIdentifier:@"TakePhotoViewController"];
        takePhotoViewController.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:takePhotoViewController animated:YES];
    }
}

- (IBAction)dismissAction:(id)sender {
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
@end
