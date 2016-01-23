//
//  LoginViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "LoginViewController.h"
#import "ChangePasswordViewController.h"
#import "StatusModel.h"
#import "UserService.h"

@interface LoginViewController ()
{
    UserService *userService;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userService =[UserService new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)fogotAction:(id)sender {
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    ChangePasswordViewController *changePasswordViewController =[storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    changePasswordViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}

- (IBAction)loginAction:(id)sender {
    SharedData *sharedData =[SharedData sharedInstance];
    
    [userService memberLoginwithLoginName:self.loginName.text andPassword:self.password.text andChannel_id:sharedData.channelId withViewController:self withDone:^(StatusModel *moel){
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
@end
