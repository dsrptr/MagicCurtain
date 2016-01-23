//
//  IndexService.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexService : NSObject
/**
 
 获取首页数据
 mid           用户id
 secret        密钥 登录时返回
 
 */

-(void)indexWithMid:(NSString *)mid
          andSecret:(NSString *)secret
 withViewController:(UIViewController*)viewcontroller
           withDone:(doneWithObject)done;

/**
获取历史推送消息
 mid          用户id
 secret        密钥 登录时返回
 
 */

-(void)pushListwithMid:(NSString *)mid
              andSecret:(NSString *)secret
    withViewController:(UIViewController*)viewcontroller
              withDone:(doneWithObject)done;
/**
 获取搜索关键字
 */
-(void)keywordListwithViewController:(UIViewController*)viewcontroller WithDone:(doneWithObject)done;

/**
 关键字搜索
 keyword     关键字
 
 block_type     搜索种类
 mid            个人id
 secret         密钥
 */
-(void)lessonSearchwithKeyword:(NSString *)keyword
                 andBlock_type:(NSString *)block_type
                        andMid:(NSString *)mid
                      andSerct:(NSString *)secret
            withViewController:(UIViewController*)viewcontroller
                      withDone:(doneWithObject)done;
/**
 获取首页数据
 mid            用户id
 secret         密钥 登录时返回
 lesson_type    课程分类
 */
-(void)lessonIndexDataWithmid:(NSString *)mid
                    andSecret:(NSString *)secret
               andLesson_type:(NSString *)lesson_type
           withViewController:(UIViewController*)viewcontroller
                     withDone:(doneWithObject)done;
/**
 根据课程分类获取课程信息
 mid                用户id
 secret             密钥 登录时返回
 lesson_type        课程分类
 page               分页
 page_size          一个页面
 */

-(void)typeLessonWithLesson_type:(NSString *)lesson_type
                          andMid:(NSString *)mid
                         andPage:(NSString *)page
                    andPage_size:(NSString *)page_size
                       andSecret:(NSString *)secret
              withViewController:(UIViewController*)viewcontroller
                        withDone:(doneWithObject)done;
/**
 根据课程分类获取课程信息
 mid                用户id
 secret             密钥 登录时返回
 lesson_id          课程id

 
 */
-(void)lessonInfoWithLesson_id:(NSString *)lesson_id
                        andMid:(NSString *)mid
                     andSecret:(NSString *)secret
            withViewController:(UIViewController*)viewcontroller
                      withDone:(doneWithObject)done;

/**
 会员留言
 mid                用户id
 secret             密钥 登录时返回
 lesson_id          课程id
 message            留言类容
 
 */

-(void)lessonMessageWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
               andLesson_id:(NSString *)lesson_id
                 andMessage:(NSString *)message
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done;
/**
 
创建支付订单
 *  @param mid      mid用户id
 *  @param secret   用户密钥
 *  @param lessonid 课程id
 *  @param done     回调函数
 *  @payModel       支付方式
 *  @lesson_type    课程还是案例
 */
-(void)create_orderWithSecret:(NSString *)secret
                 andLesson_id:(NSString *)lesson_id
                     andMoney:(NSString *)money
                  andPayModel:(NSString *)payModel
                       andMid:(NSString *)mid
                andLessonType:(NSString *)lesson_type
           withViewController:(UIViewController*)viewcontroller
                     withDone:(doneWithObject)done;

-(NSString *)jumpToBizPay;

/**
 *  收藏课程
 *
 *  @param mid      mid用户id
 *  @param secret   用户密钥
 *  @param lessonid 课程id
 *  @param done     回调函数
 */
-(void)lessonCollectWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                andLessonId:(NSString *)lessonid
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done;
/**
 *  课程点赞
 *
 *  @param mid      mid用户id
 *  @param secret   用户密钥
 *  @param lessonid 课程id
 *  @param done     回调函数
 */
-(void)lessonLikeWithMid:(NSString *)mid
               andSecret:(NSString *)secret
             andLessonId:(NSString *)lessonid
      withViewController:(UIViewController*)viewcontroller
                withDone:(doneWithObject)done;
@end
