//
//  LoginViewOperation.h
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModelLib.h>
#import "UMSocialData.h"
#import "UMSocialControllerService.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"

typedef void (^completion)(BOOL completed, NSDictionary *data);
typedef void (^done)(BOOL completed,id object);
typedef void (^finished)(NSDictionary *info);
typedef void (^doneWithObject)(id object);
typedef void (^doneWithObjectAndStatus)(int status,id object);
                                        
@interface SharedAction : NSObject<UMSocialUIDelegate>
@property (nonatomic, assign) NSStringEncoding stringEncoding;
/**
 *   分享
 *   title            分享标题
 *   url              分享URL链接
 *   text             分享文字类容
 *   imgUrl           分享显示图片链接
 *   viewController   视图分享控制器
 
 */
+(void)shareWithTitle:(NSString *)title
     andDesinationUrl:(NSString *)url
                 Text:(NSString *)text
          andImageUrl:(NSString *)imgUrl
     InViewController:(UIViewController *)viewController;
/*
*   post方法
*   url            为网络连接
*   parameters     作为参数
*    name           图片接受字段名称
*    image          图片信息
*/
+(void)postNoImage:(NSString *)url
        parameters:(NSDictionary *)parameters
    withCompletion:(completion) completed;
/*
 *   post方法
 *   url            网络连接地址
 *   paramenters    post参数
 *   name           接受图片字段名称
 *   image          接收的图片信息
 */
+(void)postOneImage:(NSString *)url
         parameters:(NSDictionary *)parameters
               name:(NSString *)name
              image:(UIImage *)image
     withCompletion:(completion) completed;
/**
 *   post方法
 *   url            网络连接地址
 *   paramenters    post参数
 *   name           接受图片字段名称
 *   image          接收的图片信息
 
 */
+(void)postImageArray:(NSString *)url
           parameters:(NSDictionary *)parameters
                 name:(NSArray *)name
           imageArray:(NSArray *)imageArray
       withCompletion:(completion) completed;
/**
*   字典转JSON
*   dic        传入的字典
 */
//+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 
    16进制颜色转UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *   公共接口输出
 *   url                访问链接URL
 *   status             状态码
 *   jsonError          JSONModelError
 *   tabbarController   统一控制器
 *   object             返回参数
 */
//+(void)commonActionWithUrl:(NSString *)url
//                 andStatus:(NSInteger)status
//                  andError:(NSString *)error
//         andJSONModelError:(JSONModelError *)jsonError
//                 andObject:(id)object
//          inViewController:(UITabBarController*)tabbarController
//                  withDone:(doneWithObject)done;
/**
 *   公共接口输出
 *   url                访问链接URL
 *   status             状态码
 *   jsonError          JSONModelError
 *   object             返回参数
 */
+(void)commonActionWithUrl:(NSString *)url
                 andStatus:(NSInteger)status
                  andError:(NSString *)error
         andJSONModelError:(JSONModelError *)jsonError
                 andObject:(id)object
        withViewController:(UIViewController *)viewController
                  withDone:(doneWithObject)done;
/**
 设置刷新头
 */
+(void)setupRefreshWithTableView:(UITableView *)tableview
                        toTarget:(UIViewController *)target;
@end
