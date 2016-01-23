//
//  WaitingViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "WaitingViewController.h"
#import "StatusModel.h"
#define Member_Info_URL [BaseUrl stringByAppendingString:@"Member/member_info/mid/%@/secret/%@"]
@interface WaitingViewController ()

@end

@implementation WaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissAction:(id)sender {
    SharedData *sharedData = [SharedData sharedInstance];
    LoginModel *user=sharedData.user;
    NSString *urlString=[NSString stringWithFormat:Member_Info_URL,user.mid,user.secret];
    [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
        if (model.status==2) {
            StatusModelInfo *object=model.info;
            sharedData.user=object.member;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"postSuccess" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
@end
