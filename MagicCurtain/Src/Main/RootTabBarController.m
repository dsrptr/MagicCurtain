//
//  RootTabBarController.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "RootTabBarController.h"
#import "Index0NavigationController.h"
#import "Index1NavigationController.h"
#import "Index2NavigationController.h"
#import "Index3NavigationController.h"
#import "Index4NavigationController.h"
#import "UserNavigationController.h"
#import "StatusModel.h"



@interface RootTabBarController ()<UIAlertViewDelegate>
{
    Index0NavigationController *index0Nav;
    Index1NavigationController *index1Nav;
    Index2NavigationController *index2Nav;
    Index3NavigationController *index3Nav;
    Index4NavigationController *index4Nav;
    
    NSInteger index;
}
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect frame = DeviceFrame;
//    self.tabBar.frame = CGRectMake(0, CGRectGetHeight(frame)-44, CGRectGetWidth(frame), 44);
//    UIView * transitionView = [[self.view subviews] objectAtIndex:0];
//    frame.size.height = CGRectGetHeight(frame) -44;
//    transitionView.frame = frame;
    index=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginoutAction) name:@"LoginOut" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(postSuccessAction) name:@"postSuccess" object:nil];
    self.delegate=self;
    UIStoryboard *storyboard0=[UIStoryboard storyboardWithName:@"Index0" bundle:nil];
    UIStoryboard *storyboard1=[UIStoryboard storyboardWithName:@"Index1" bundle:nil];
    UIStoryboard *storyboard2=[UIStoryboard storyboardWithName:@"Index2" bundle:nil];
    UIStoryboard *storyboard3=[UIStoryboard storyboardWithName:@"Index3" bundle:nil];
    UIStoryboard *storyboard4=[UIStoryboard storyboardWithName:@"Index4" bundle:nil];
    
    index0Nav= [storyboard0 instantiateViewControllerWithIdentifier:@"Index0NavigationController"];
    index1Nav =[storyboard1 instantiateViewControllerWithIdentifier:@"Index1NavigationController"];
    index2Nav =[storyboard2 instantiateViewControllerWithIdentifier:@"Index2NavigationController"];
    index3Nav =[storyboard3 instantiateViewControllerWithIdentifier:@"Index3NavigationController"];
    index4Nav =[storyboard4 instantiateViewControllerWithIdentifier:@"Index4NavigationController"];

    [self addChildViewController:index4Nav];
    [self addChildViewController:index0Nav];
    [self addChildViewController:index1Nav];
    [self addChildViewController:index2Nav];
    [self addChildViewController:index3Nav];
}

-(void)setIndex:(NSInteger)index andLessonType:(NSString *)lessontype{
    index0Nav.index=index;
    index0Nav.lessonType=lessontype;
    NSString *indexs=[NSString stringWithFormat:@"%ld",(long)index];
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:indexs,@"indexPath",lessontype,@"lesson_type",nil];
    //    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"selcetLesonType" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter]postNotification:notification];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginoutAction{
    self.selectedIndex=0;
//    UINavigationController *nav = self.viewControllers[0];
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[Index2NavigationController class]]||[viewController isKindOfClass:[Index3NavigationController class]]) {
        SharedData *sharedData = [SharedData sharedInstance];
        if ((sharedData.user.mid==nil||sharedData.user.secret==nil||[sharedData.user.mid isEqualToString:@""]||[sharedData.user.secret isEqualToString:@""])) {
            self.selectedIndex=index;
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
            UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
            [self presentViewController:userNavi animated:YES completion:nil];
        }
    }else{
        index=tabBarController.selectedIndex;
    }
}
@end
