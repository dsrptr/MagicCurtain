//
//  ChangePasswordViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UserService.h"
#import "StatusModel.h"
#import "MyMD5.h"
@interface ChangePasswordViewController ()
{
    UserService *userService;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userService =[UserService new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sendCode:(id)sender {
    [userService verifyCodeWithMobile:self.phoneNumber.text
                   withViewController:self
                             withDone:^(StatusModel *model){
        [SVProgressHUD showSuccessWithStatus:model.msg];
    }];
    
}

- (IBAction)post:(id)sender {
    [userService passwordForgetwith:self.phoneNumber.text
                     andVerify_code:self.code.text
                        andPassword:self.password1.text
                   andPasswordAgain:self.password2.text
                 withViewController:self
                          withDonel:^(StatusModel *model){
        [SVProgressHUD showSuccessWithStatus:@"您的密码修改成功，请牢记您的密码"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
@end
