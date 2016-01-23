//
//  Index1Service.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/6.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index1Service.h"
#import "LessonIndexModel.h"
#import <JSONModelLib.h>
#import "StatusModel.h"
#import "CaseInfoModel.h"

#define Case_Index_URL [BaseUrl stringByAppendingString:@"Case/index/mid/%@/secret/%@"]
#define Case_Info_URL [BaseUrl stringByAppendingString:@"Case/case_info/lesson_id/%@/mid/%@/secret/%@"]
#define Case_List_URL [BaseUrl stringByAppendingString:@"Case/case_list/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Case_Collect_URL [BaseUrl stringByAppendingString:@"Case/case_collect/mid/%@/lesson_id/%@/secret/%@"]
#define Case_Message_URL [BaseUrl stringByAppendingString:@"Case/case_message"]
//#define case_collect_URL [BaseUrl stringByAppendingString:@"Case/case_collect/mid/%@/lesson_id/%@/secret/%@"]



@implementation Index1Service

-(void)caseIndexWithMid:(NSString *)mid
              andSecret:(NSString *)secret
     withViewController:(UIViewController*)viewcontroller
               withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Case_Index_URL,mid,secret];
    [LessonIndexModel getModelFromURLWithString:urlString
                                     completion:^(LessonIndexModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:(UIViewController*)viewcontroller
                                 withDone:done];
    }];
}
-(void)caseInfoWithLessonId:(NSString *)lessonId
                     andMid:(NSString *)mid
                  andSecret:(NSString *)secret
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Case_Info_URL,lessonId,mid,secret];
    [CaseInfoModel getModelFromURLWithString:urlString
                                  completion:^(CaseInfoModel *model,JSONModelError *error){
    [SharedAction commonActionWithUrl:urlString
                            andStatus:model.status
                             andError:model.msg
                    andJSONModelError:error
                            andObject:model.info
                   withViewController:(UIViewController*)viewcontroller
                             withDone:done];
        
    }];
}
-(void)caseListWithMid:(NSString *)mid
             andSecret:(NSString *)secret
               andPage:(NSString *)pageString
           andPageSize:(NSString *)pageSize
    withViewController:(UIViewController*)viewcontroller
              withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Case_List_URL,mid,secret,pageString,pageSize];
    [LessonIndexModel getModelFromURLWithString:urlString
                                     completion:^(LessonIndexModel *model,JSONModelError *error){
        done(model.info);
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
         withViewController:(UIViewController*)viewcontroller
                                 withDone:done];
    }];
}

-(void)caseCollectWithMid:(NSString *)mid
                andSecret:(NSString *)secret
              andLessonId:(NSString *)lessonid
       withViewController:(UIViewController*)viewcontroller
                 withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Case_Collect_URL,mid,lessonid,secret];
    [StatusModel getModelFromURLWithString:urlString
                                completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model
                       withViewController:(UIViewController*)viewcontroller
                                 withDone:done];
    }];
}

-(void)caseMessageWithMid:(NSString *)mid
                andSecret:(NSString *)secret
               andMessage:(NSString *)message
              andLseeonId:(NSString *)lessondId
       withViewController:(UIViewController*)viewcontroller
                 WithDone:(doneWithObject)done{
    NSDictionary *parameters =[[NSDictionary alloc] initWithObjects:@[mid,secret,message,lessondId] forKeys:@[@"mid",@"secret",@"message",@"lessond_id"]];
    [SharedAction postNoImage:Case_Message_URL
                   parameters:parameters
               withCompletion:^(BOOL completion,NSDictionary *info){
    StatusModel *model =[[StatusModel alloc] initWithDictionary:info
                                                          error:nil];
        [SharedAction commonActionWithUrl:Case_Message_URL
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:nil
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];

}
@end
