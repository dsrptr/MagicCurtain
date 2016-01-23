    //
//  LoginViewOperation.m
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "SharedAction.h"
#import "AFNetworking.h"
#import <JSONModelLib.h>
#import "AFHTTPSessionManager.h"
#import <sqlite3.h>
#import <FMDB.h>

#import "UserNavigationController.h"
#import "UserNavigationController.h"
#import "UserService.h"
#import "StatusModel.h"
#import "MJRefresh.h"
@implementation SharedAction
+(void)shareWithTitle:(NSString *)title
     andDesinationUrl:(NSString *)url
                 Text:(NSString *)text
          andImageUrl:(NSString *)imgUrl
     InViewController:(UIViewController *)viewController{
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        UIImage *img = nil;
        if ([imgUrl hasPrefix:@"http"]) {
            img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        }else{
            img = [UIImage imageNamed:imgUrl];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
            [UMSocialData defaultData].extConfig.qqData.title = title;
            [UMSocialData defaultData].extConfig.qzoneData.title = title;
            [UMSocialSnsService presentSnsIconSheetView:viewController
                                                 appKey:UmengAppkey
                                              shareText:text
                                             shareImage:img
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                               delegate:(id)viewController];
            [SVProgressHUD dismiss];
        });
    });
}

//Post
+(void)postOneImage:(NSString *)url parameters:(NSDictionary *)parameters name:(NSString *)name image:(UIImage *)image withCompletion:(completion) completed{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [session POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
        if (imageData) {
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpeg"];
        }
    } success:^(NSURLSessionTask *task, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
}

//post
+(void)postNoImage:(NSString *)url
        parameters:(NSDictionary *)parameters
    withCompletion:(completion) completed{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
    } success:^(NSURLSessionTask *task, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];
}

//上传多张图片
+(void)postImageArray:(NSString *)url parameters:(NSDictionary *)parameters name:(NSArray *)name imageArray:(NSArray *)imageArray withCompletion:(completion) completed{
   AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
        for (int i=0; i<imageArray.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.5);
            [formData appendPartWithFileData:imageData name:name[i] fileName:[NSString stringWithFormat:@"%@.jpg",name[i]] mimeType:@"image/jpeg"];
        }
        
    } success:^(NSURLSessionTask *task, id responseObject) {
        [SharedAction operationAfterSucccessActionWithOperation:responseObject andResponseObject:responseObject andUrl:url andParameters:parameters withCompletion:completed];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SharedAction operationAfterFailActionWithUrl:url andPatameters:parameters andError:error withCompletion:completed];
    }];

}

+(void)operationAfterFailActionWithUrl:(NSString *)url
                         andPatameters:(NSDictionary *)parameters
                              andError:(NSError *)error withCompletion:(completion) completed{
    [self logUrl:url parameters:parameters];
    NSLog(@"Error: %@", error);
    completed(NO, nil);
    [SVProgressHUD dismiss];
}

+(void)operationAfterSucccessActionWithOperation:(AFJSONResponseSerializer *)operation
                               andResponseObject:(id)responseObject
                                          andUrl:(NSString *)url
                                   andParameters:(NSDictionary *)parameters
                                  withCompletion:(completion) completed{
    NSLog(@"Success: ***** %@ ***** ", operation);
    [self logUrl:url parameters:parameters];
    NSNumber *status = responseObject[@"status"];
    NSLog(@"status = %@", status);
    if (![operation isEqual:@2]) {
        completed(NO, responseObject);
    } else {
        completed(YES, responseObject);
    }
}

+(void)commonActionWithUrl:(NSString *)url
                 andStatus:(NSInteger)status
                  andError:(NSString *)error
         andJSONModelError:(JSONModelError *)jsonError
                 andObject:(id)object
        withViewController:(UIViewController *)viewController
                  withDone:(doneWithObject)done{
    NSLog(@"status=%ld url=%@ message=%@",(long)status,url,error);
    SharedData *sharedData=[SharedData sharedInstance];
    UIAlertController *alertViewcontroller;
    UIAlertAction *cancelAction;
    UIAlertAction *okAction;
    if (status==2) {
        [SVProgressHUD dismiss];
         done(object);
    }else if(status==5){
        alertViewcontroller=[UIAlertController alertControllerWithTitle:@"您的账号出现异常" message:@"您的帐号在其他设备上登录是否要重新登录"  preferredStyle:UIAlertControllerStyleAlert];
        cancelAction= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            sharedData.user=nil;
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"User" bundle:nil];
            UserNavigationController *userNavi=[storyboard instantiateViewControllerWithIdentifier:@"UserNavigationController"];
            [viewController presentViewController:userNavi animated:YES completion:nil];
        }];
        okAction= [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UserService *userService=[UserService new];
            [userService memberLoginwithLoginName:sharedData.loginname andPassword:sharedData.password andChannel_id:sharedData.channelId withViewController:viewController withDone:^(StatusModel *moel){
                [SVProgressHUD dismiss];
            }];
        }];
        [alertViewcontroller addAction:cancelAction];
        [alertViewcontroller addAction:okAction];
        [viewController presentViewController:alertViewcontroller animated:YES completion:nil];
        [SVProgressHUD dismiss];
    }else{
        [SVProgressHUD showErrorWithStatus:error];
    }
}


+(void) logUrl:(NSString *)url parameters:(NSDictionary *)parameters {
    NSString *fullUrl = [NSString stringWithFormat:@"%@", url];
    int index = 0;
    for (NSString *key in parameters) {
        if (index == 0) {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"?"];
        } else {
            fullUrl = [NSString stringWithFormat:@"%@%@", fullUrl, @"&"];
        }
        fullUrl = [NSString stringWithFormat:@"%@%@=%@", fullUrl, key, parameters[key]];
        index ++;
    }
    NSLog(@"*** url ***: %@", fullUrl);
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    NSLog(@"%f",(float) r );
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(void)setupRefreshWithTableView:(UITableView *)tableview toTarget:(UIViewController *)target
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [tableview addHeaderWithTarget:target action:@selector(headerRereshing)];
    //    [tableview headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tableview addFooterWithTarget:target action:@selector(footerRereshing)];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableview.headerPullToRefreshText = @"下拉可以刷新了";
    tableview.headerReleaseToRefreshText = @"松开马上刷新了";
    tableview.headerRefreshingText = @"正在帮你刷新中";
    tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableview.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableview.footerRefreshingText = @"正在帮你加载中";
}

-(void)headerRereshing{
    
}

-(void)footerRereshing{
}

@end
