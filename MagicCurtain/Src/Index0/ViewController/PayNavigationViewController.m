//
//  PayNavigationViewController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/15.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "PayNavigationViewController.h"
#import "CreatOrderViewController.h"
@interface PayNavigationViewController ()

@end

@implementation PayNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CreatOrderViewController *creatOrder=self.viewControllers[0];
    creatOrder.payMoney=self.payMoney;
    creatOrder.lessonType=self.lessonType;
    creatOrder.lessonId=self.lessonId;
    creatOrder.indexPath=self.indexPath;
    creatOrder.lessonName=self.lessonName;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
