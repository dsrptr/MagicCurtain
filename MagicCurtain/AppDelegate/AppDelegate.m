//
//  AppDelegate.m
//  MagicCurtain
//
//  Created by macbook pro on 15/10/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "BPush.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UserService.h"
#import "StatusModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PushHistoryViewController.h"
//#import "MobClick.h"
#define MainNavBarColor [UIColor whiteColor]
@interface AppDelegate ()<UIViewControllerPreviewingDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1.0];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UITabBar appearance]setTintColor:[SharedAction colorWithHexString:@"00B050"]];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UINavigationBar appearance] setTintColor:MainNavBarColor];
     [self setLibPushWithOptions:launchOptions];
    SharedData *sharedData =[SharedData sharedInstance];
    if ([sharedData.loginStatus isEqualToString:@"YES"]) {
        [SVProgressHUD show];
        UserService *userService=[UserService new];
        [userService memberLoginwithLoginName:sharedData.loginname andPassword:sharedData.password andChannel_id:sharedData.channelId withViewController:nil withDone:^(StatusModel *model){
            if (model.status==2) {
                
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginFailed" object:nil];
            }
        }];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginFailed" object:nil];
    }
    [self setupSocialSharePlatform];
   
    
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
//    return YES;
}

-(void) createItem
{
    //自定义icon 的初始化方法
    //    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"your_icon"];
    //    UIMutableApplicationShortcutItem *item0 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"com.your.helloWorld" localizedTitle:@"Title" localizedSubtitle:@"sub Title" icon:icon1 userInfo:nil];
    //这种是随意没有icon 的
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"test.com.A" localizedTitle:@"三条A"];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"test.com.B" localizedTitle:@"三条B"];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"test.com.C" localizedTitle:@"三条C"];
    
    NSArray *addArr = @[item2,item3,item1];
    //为什么这两句话可以不用，因为我们可以在plist 里面 加入 UIApplicationShortcutItems
    //    NSArray *existArr = [UIApplication sharedApplication].shortcutItems;
    //    [UIApplication sharedApplication].shortcutItems = [existArr arrayByAddingObjectsFromArray:addArr];
     [[UIApplication sharedApplication] setShortcutItems:addArr];
}

//- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
//    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);
//    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PushHistoryViewController *pushHistoryViewController =[storyboard instantiateViewControllerWithIdentifier:@"PushHistoryViewController"];
//    [application.keyWindow.rootViewController presentViewController:pushHistoryViewController animated:NO completion:nil];
//}


-(void)setLibPushWithOptions:(NSDictionary *)launchOptions{
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
//#warning 上线 AppStore 时需要修改BPushMode为BPushModeProduction 需要修改Apikey为自己的Apikey
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"0VhLzoqgnSB3iGUeG0GnAIZR" pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


-(void)setupSocialSharePlatform{
    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiXinAppID appSecret:WeiXinAppSecret url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppSecret url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setSupportWebView:YES];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"url=%@   sourceApplication=%@   url.host=%@",url,sourceApplication,url.host);
    //如果极简SDK不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *status = [resultDic objectForKey:@"ResultStatus"];
            NSString *trues=[resultDic objectForKey:@"success"];
            NSLog(@"%@%@",status,trues);
            if ([status isEqualToString:@"9000"]||[trues isEqualToString:@"true"]) {
                SharedData *sharedData =[SharedData sharedInstance];
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:sharedData.lessonType,@"lessonType",sharedData.lessonId,@"lessonId",nil];
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"PaySuccess" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter]postNotification:notification];
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){
        //支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                SharedData *sharedData =[SharedData sharedInstance];
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:sharedData.lessonType,@"lessonType",sharedData.lessonId,@"lessonId",nil];
                //创建通知
                NSNotification *notification =[NSNotification notificationWithName:@"PaySuccess" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter]postNotification:notification];
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    return  [UMSocialSnsService handleOpenURL:url];
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // 打印到日志 textView 中
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"backgroud : %@",userInfo);
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        SharedData *sharedData =[SharedData sharedInstance];
        sharedData.channelId=[result objectForKey:@"channel_id"];
    }];
    // 打印到日志 textView 中
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    NSLog(@"%@",userInfo);
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
