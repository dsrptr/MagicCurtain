//
//  Index0NavigationController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index0NavigationController.h"
#import "Index0ViewController.h"
@interface Index0NavigationController ()

@end

@implementation Index0NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    Index0ViewController *vic =self.viewControllers[0];
    vic.index=self.index;
    vic.lessonType=self.lessonType;
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
