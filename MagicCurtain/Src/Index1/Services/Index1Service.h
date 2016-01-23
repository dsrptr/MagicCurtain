//
//  Index1Service.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/6.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index1Service : NSObject
/**
 获取案例列表信息
 
 mid                用户id
 secret             密钥 登录时返回
 
 */

-(void)caseIndexWithMid:(NSString *)mid
              andSecret:(NSString *)secret
     withViewController:(UIViewController*)viewcontroller
               withDone:(doneWithObject)done;
/**
 获取案例列表信息
 lessonId           案例id
 mid                用户id
 secret             密钥 登录时返回
 
 */
-(void)caseInfoWithLessonId:(NSString *)lessonId
                     andMid:(NSString *)mid
                  andSecret:(NSString *)secret
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done;

/**
 获取案例列表信息
 mid                用户id
 secret             密钥 登录时返回
 pageString         分页
 pageSize           每页条数
 
 */
-(void)caseListWithMid:(NSString *)mid
             andSecret:(NSString *)secret
               andPage:(NSString *)pageString
           andPageSize:(NSString *)pageSize
    withViewController:(UIViewController*)viewcontroller
              withDone:(doneWithObject)done;
/**
 *  案例收藏
 *
 *  @param mid      用户id
 *  @param secret   用户密钥登陆时返回
 *  @param lessonid 课程id
 *  @param done     回调函数
 */
-(void)caseCollectWithMid:(NSString *)mid
                andSecret:(NSString *)secret
              andLessonId:(NSString *)lessonid
       withViewController:(UIViewController*)viewcontroller
                 withDone:(doneWithObject)done;
/**
 *  会员留言
 *
 *  @param mid       mid用户id
 *  @param secret    用户密钥 登陆时返回
 *  @param message   会员留言内容
 *  @param lessondId 会员留言课程id
 *  @param done      回调函数
 */
-(void)caseMessageWithMid:(NSString *)mid
                andSecret:(NSString *)secret
               andMessage:(NSString *)message
              andLseeonId:(NSString *)lessondId
       withViewController:(UIViewController*)viewcontroller
                 WithDone:(doneWithObject)done;
@end
