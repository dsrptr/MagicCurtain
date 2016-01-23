//
//  RegistViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "RegistViewController.h"
#import "UserService.h"
#import "VerifyModel.h"
#import "LoginModel.h"
#import "StatusModel.h"
#import "WebViewController.h"
@interface RegistViewController ()
{
    UserService *userService;
    NSInteger agreen;
}
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    agreen=0;
    self.agreenBtn.layer.borderColor=[SharedAction colorWithHexString:@"00B050"].CGColor;
    self.agreenBtn.layer.borderWidth=2;
    self.hidView.hidden=YES;
    userService =[UserService new];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registAction:(id)sender {
    WebViewController *target = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    target.navigationController.navigationItem.leftBarButtonItem.title=@"注册";
    target.title=@"注册协议";
    target.urlString = @"http://www.bywindow.com/inf.php/Member/net_agree";
    target.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:target animated:YES];
}

- (IBAction)saveAction:(id)sender {
    if (agreen==0) {
        [SVProgressHUD showErrorWithStatus:@"请先同意注册协议!"];
        return;
    }
    SharedData *shareData=[SharedData sharedInstance];
    [userService memberRegistWithmobile:self.mobel.text
                            andPassword:self.password.text
                           andPassword2:self.passwordAgain.text
                          andVerifyCode:self.verifyCode.text
                          andInviteCode:@"123"
                     withViewController:self
                               withDone:^(StatusModel *model){
        if (model.status ==2) {
            [userService memberLoginwithLoginName:self.mobel.text
                                      andPassword:self.password.text
                                    andChannel_id:shareData.channelId
                               withViewController:self
                                         withDone:^(StatusModel *model){
                                             if (model.status ==2) {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                             }
                                         }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.msg];
        }
    }];
}

- (IBAction)aggrenAction:(id)sender {
    if (agreen==0) {
        self.hidView.hidden=NO;
        agreen=1;
    }else{
        agreen=0;
        self.hidView.hidden=YES;
    }
}

- (IBAction)postVerifyCode:(id)sender {
    [userService verifyCodeWithMobile:self.mobel.text
                   withViewController:self
                             withDone:^(VerifyModel *model){
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
}
@end
