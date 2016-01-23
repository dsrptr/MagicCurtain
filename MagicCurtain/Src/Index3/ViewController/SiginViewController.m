//
//  SiginViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "SiginViewController.h"
#import "Index3Service.h"
#import "StatusModel.h"
@interface SiginViewController ()
{
    Index3Service *index3Service;
    LoginModel *user;
    SharedData *sharedData;
}

@end

@implementation SiginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index3Service=[Index3Service new];
     sharedData=[SharedData sharedInstance];
    user=sharedData.user;
    self.singDetail.text=self.detailString;
    [self.singDetail becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)postAction:(id)sender {
    if (_changeType==0) {
        [index3Service memberNickNameWithMid:user.mid andSercet:user.secret andNIckName:self.singDetail.text withViewController:self withDone:^(StatusModel *model){
            if (model.status==2) {
                [self.navigationController popViewControllerAnimated:YES];
                user.nick_name=self.singDetail.text;
                sharedData.user=user;
            }
        }];
    }else if(_changeType==1){
        [index3Service loginNameWithMid:user.mid  andSercet:user.secret andLoginName:self.singDetail.text withViewController:self withDone:^(StatusModel *model){
            if (model.status==2) {
                [self.navigationController popViewControllerAnimated:YES];
                sharedData.loginname=self.singDetail.text;
                user.login_name=self.singDetail.text;
                sharedData.user=user;
            }
        }];
    }
}
@end
