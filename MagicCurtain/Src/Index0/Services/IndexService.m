//
//  IndexService.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "IndexService.h"
#import <JSONModelLib.h>
#import "StatusModel.h"
#import "IndexModel.h"
#import "KeyWordModel.h"
#import "LessonIndexModel.h"
#import "LessonDetailModel.h"
#import "Create_pay_order.h"
#import "SeachResultModel.h"
#import "WXApi.h"

#define Index_URL [BaseUrl stringByAppendingString:@"Index/index/mid/%@/secret/%@"]
#define Push_List_URL [BaseUrl stringByAppendingString:@"Push/push_list/mid/%@/secret/%@"]
#define Keyword_List_URL [BaseUrl stringByAppendingString:@"Advert/keyword_list"]
#define Lesson_Search_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_search"]
#define Lesson_Index_URL [BaseUrl stringByAppendingString:@"Lesson/index/mid/%@/secret/%@/lesson_type/%@"]
#define Type_Lesson_URL [BaseUrl stringByAppendingString:@"Lesson/type_lesson/mid/%@/secret/%@/page/%@/lesson_type/%@/page_size/%@"]
#define Lesson_Info_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_info/mid/%@/lesson_id/%@/secret/%@"]
#define Lesson_Message_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_message"]
#define Lesson_Like_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_like/mid/%@/lesson_id/%@/secret/%@"]

#define Create_pay_orderURL [BaseUrl stringByAppendingString: @"Pay/create_pay_order/mid/%@/secret/%@/money/%@/lesson_id/%@/block_type/%@/pay_mode/%@"]


#define Lesson_Collect_URL [BaseUrl stringByAppendingString:@"Lesson/lesson_collect/mid/%@/lesson_id/%@/secret/%@"]

@implementation IndexService

-(void)indexWithMid:(NSString *)mid
          andSecret:(NSString *)secret
 withViewController:(UIViewController*)viewcontroller
           withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Index_URL,mid,secret];
    [IndexModel getModelFromURLWithString:urlString
                               completion:^(IndexModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}


-(void)pushListwithMid:(NSString *)mid
              andSecret:(NSString *)secret
    withViewController:(UIViewController*)viewcontroller
              withDone:(doneWithObject)done{
    [SVProgressHUD show];
     NSString *urlString=[NSString stringWithFormat:Push_List_URL,mid,secret];
    [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];
    
}

-(void)keywordListwithViewController:(UIViewController*)viewcontroller WithDone:(doneWithObject)done{
    [KeyWordModel getModelFromURLWithString:Keyword_List_URL
                                 completion:^(KeyWordModel *model,JSONModelError *error){
        [SVProgressHUD show];
        [SharedAction commonActionWithUrl:Keyword_List_URL
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)lessonSearchwithKeyword:(NSString *)keyword
                 andBlock_type:(NSString *)block_type
                        andMid:(NSString *)mid
                      andSerct:(NSString *)secret
            withViewController:(UIViewController*)viewcontroller
                      withDone:(doneWithObject)done{
    NSDictionary *parameters;
    if ([mid isEqualToString:@""]||[secret isEqualToString:@""]||mid==nil||secret==nil) {
        parameters=[[NSDictionary alloc] initWithObjects:@[keyword,block_type] forKeys:@[@"keyword",@"block_type"]];
    }else{
            parameters=[[NSDictionary alloc] initWithObjects:@[keyword,block_type,mid,secret]forKeys:@[@"keyword",@"block_type",@"mid",@"secret"]];
        }
    [SharedAction postNoImage:Lesson_Search_URL parameters:parameters withCompletion:^(BOOL complet,NSDictionary *info){
        SeachResultModel *model =[[SeachResultModel alloc] initWithDictionary:info error:nil];
        [SharedAction commonActionWithUrl:Lesson_Search_URL
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:nil
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];
    
    
}

-(void)lessonIndexDataWithmid:(NSString *)mid
                    andSecret:(NSString *)secret
               andLesson_type:(NSString *)lesson_type
           withViewController:(UIViewController*)viewcontroller
                     withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Lesson_Index_URL,mid,secret,lesson_type];
    [LessonIndexModel getModelFromURLWithString:urlString completion:^(LessonIndexModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)typeLessonWithLesson_type:(NSString *)lesson_type
                          andMid:(NSString *)mid
                         andPage:(NSString *)page
                    andPage_size:(NSString *)page_size
                       andSecret:(NSString *)secret
              withViewController:(UIViewController*)viewcontroller
                        withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Type_Lesson_URL,mid,secret,page,lesson_type,page_size];
    [LessonIndexModel getModelFromURLWithString:urlString completion:^(LessonIndexModel *model,JSONModelError *error){
        [SVProgressHUD showSuccessWithStatus:model.msg];
//        done(model.info);
    
        [SharedAction commonActionWithUrl:urlString
                                andStatus:2
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)lessonInfoWithLesson_id:(NSString *)lesson_id
                        andMid:(NSString *)mid
                     andSecret:(NSString *)secret
            withViewController:(UIViewController*)viewcontroller
                      withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSString *urlString=[NSString stringWithFormat:Lesson_Info_URL,mid,lesson_id,secret];
    [LessonDetailModel getModelFromURLWithString:urlString completion:^(LessonDetailModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)lessonMessageWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
               andLesson_id:(NSString *)lesson_id
                 andMessage:(NSString *)message
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done{
    [SVProgressHUD show];
    NSDictionary *praments=[[NSDictionary alloc] initWithObjects:@[mid,secret,lesson_id,message] forKeys:@[@"mid",@"secret",@"lesson_id",@"message"]];
    [SharedAction postNoImage:Lesson_Message_URL parameters:praments withCompletion:^(BOOL completion,NSDictionary *info){
        StatusModel *model =[[StatusModel alloc] initWithDictionary:info error:nil];
        [SharedAction commonActionWithUrl:Lesson_Message_URL
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:nil
                                andObject:model
                                 withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)create_orderWithSecret:(NSString *)secret
                 andLesson_id:(NSString *)lesson_id
                    andMoney:(NSString *)money
                 andPayModel:(NSString *)payModel
                       andMid:(NSString *)mid
                andLessonType:(NSString *)lesson_type
          withViewController:(UIViewController*)viewcontroller
                    withDone:(doneWithObject)done{
        NSString *urlString = [NSString stringWithFormat:Create_pay_orderURL,mid,secret,money,lesson_id,lesson_type,payModel];
        NSLog(@"%@",urlString);
        [Create_pay_order getModelFromURLWithString:urlString completion:^(Create_pay_order *model,JSONModelError *error){
            [SharedAction commonActionWithUrl:urlString
                                    andStatus:model.status
                                     andError:model.msg
                            andJSONModelError:error
                                    andObject:model.info
                           withViewController:viewcontroller
                                     withDone:done];
        }];
}
-(NSString *)jumpToBizPay {
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}

-(void)lessonCollectWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                andLessonId:(NSString *)lessonid
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done{
    
    NSString *urlString =[NSString stringWithFormat:Lesson_Collect_URL,mid,lessonid,secret];
    [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model withViewController:viewcontroller withDone:done];
    }];
}
-(void)lessonLikeWithMid:(NSString *)mid
               andSecret:(NSString *)secret
             andLessonId:(NSString *)lessonid
      withViewController:(UIViewController*)viewcontroller
                withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Lesson_Like_URL,mid,lessonid,secret];
    [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];

}
@end
