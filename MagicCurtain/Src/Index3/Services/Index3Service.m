//
//  Index3Service.m
//  MagicCurtain
//
//  Created by macbook pro on 15/12/7.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "Index3Service.h"
#import "StudyModel.h"
#import <JSONModelLib.h>
#import "StatusModel.h"
#import "ArreaModel.h"
#import "RefModel.h"
#import "PointModel.h"
#import "MemberMessageModel.h"
#define Member_Collect_URL [BaseUrl stringByAppendingString:@"Member/member_collect/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Member_Share_URL [BaseUrl stringByAppendingString:@"Member/member_share/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Member_Study_URL [BaseUrl stringByAppendingString:@"Member/member_study/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Member_Buy_URL [BaseUrl stringByAppendingString:@"Member/member_buy/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Member_Nick_Name_URL [BaseUrl stringByAppendingString:@"Member/nick_name"]
#define Member_Login_Name_URL [BaseUrl stringByAppendingString:@"Member/login_name"]
#define Member_Province_URL [BaseUrl stringByAppendingString:@"Member/province/mid/%@/secret/%@"]
#define Member_City_URL [BaseUrl stringByAppendingString:@"Member/city/mid/%@/secret/%@/province/%@"]
#define Member_Area_URL [BaseUrl stringByAppendingString:@"Member/area/mid/%@/secret/%@/city/%@"]
#define Member_Address_URL [BaseUrl stringByAppendingString:@"Member/address"]
#define Member_Head_img_URL [BaseUrl stringByAppendingString:@"Member/head_img"]
#define Member_About_URL [BaseUrl stringByAppendingString:@"Member/member_about"]
#define Member_Contact_URL [BaseUrl stringByAppendingString:@"Member/member_contact"]
#define Member_Sign_URL [BaseUrl stringByAppendingString:@"Member/member_sign/mid/%@/secret/%@"]
#define Member_Audit_URL [BaseUrl stringByAppendingString:@"Member/member_audit"]
#define Member_Ref_URL [BaseUrl stringByAppendingString:@"Member/member_ref/mid/%@/secret/%@/page/%@/page_size/%@"]
#define Memeber_Mesage_URL [BaseUrl stringByAppendingString:@"Member/member_message/mid/%@/secret/%@/page/%@/page_size/%@"]

@implementation Index3Service

-(void)memberCollectWithMid:(NSString *)mid
                  andSercet:(NSString *)sercet
                    andPage:(NSString *)page
                andPageSize:(NSString *)pageSize
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Member_Collect_URL ,mid,sercet,page,pageSize];
    [StudyModel getModelFromURLWithString:urlString completion:^(StudyModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info  withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberShareWithMid:(NSString *)mid
                  andSercet:(NSString *)sercet
                    andPage:(NSString *)page
                andPageSize:(NSString *)pageSize
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Member_Share_URL ,mid,sercet,page,pageSize];
    [StudyModel getModelFromURLWithString:urlString completion:^(StudyModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];

}
-(void)memberStudyWithMid:(NSString *)mid
                andSercet:(NSString *)sercet
                  andPage:(NSString *)page
              andPageSize:(NSString *)pageSize
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Member_Study_URL ,mid,sercet,page,pageSize];
    [StudyModel getModelFromURLWithString:urlString completion:^(StudyModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberBuyWithMid:(NSString *)mid
                andSercet:(NSString *)sercet
                  andPage:(NSString *)page
              andPageSize:(NSString *)pageSize
     withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Member_Buy_URL ,mid,sercet,page,pageSize];
    [StudyModel getModelFromURLWithString:urlString completion:^(StudyModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberNickNameWithMid:(NSString *)mid
                   andSercet:(NSString *)secret
                 andNIckName:(NSString *)nickName
          withViewController:(UIViewController *)viewcontroller
                    withDone:(doneWithObject)done{
    NSDictionary *parament=[[NSDictionary alloc] initWithObjects:@[mid,secret,nickName] forKeys:@[@"mid",@"secret",@"nick_name"]];
    [SharedAction postNoImage:Member_Nick_Name_URL parameters:parament withCompletion:^(BOOL completion,NSDictionary *info){
        StatusModel *model =[[StatusModel alloc] initWithDictionary:info error:nil];
        [SharedAction commonActionWithUrl:Member_Nick_Name_URL andStatus:model.status andError:model.msg andJSONModelError:nil andObject:model withViewController:viewcontroller withDone:done];
    }];
}
-(void)loginNameWithMid:(NSString *)mid
              andSercet:(NSString *)secret
            andLoginName:(NSString *)login_name
     withViewController:(UIViewController *)viewcontroller
               withDone:(doneWithObject)done{
    NSDictionary *parament=[[NSDictionary alloc] initWithObjects:@[mid,secret,login_name] forKeys:@[@"mid",@"secret",@"login_name"]];
    [SharedAction postNoImage:Member_Login_Name_URL parameters:parament withCompletion:^(BOOL completion,NSDictionary *info){
        StatusModel *model =[[StatusModel alloc] initWithDictionary:info error:nil];
        [SharedAction commonActionWithUrl:Member_Login_Name_URL andStatus:model.status
                                 andError:model.msg andJSONModelError:nil
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}

-(void)memberProvinceWithMid:(NSString *)mid
                   andSecret:(NSString *)secret
                     andType:(NSInteger)type
                  andKeyWord:(NSString *)keyWord
          withViewController:(UIViewController *)viewcontroller
                    withDone:(doneWithObject)done{
    NSString *urlString;
    if (type==0) {
       urlString =[NSString stringWithFormat:Member_Province_URL ,mid,secret];
    }else if (type==1){
        urlString =[NSString stringWithFormat:Member_City_URL ,mid,secret,keyWord];
    }else{
        urlString =[NSString stringWithFormat:Member_Area_URL ,mid,secret,keyWord];
    }
    [ArreaModel getModelFromURLWithString:urlString completion:^(ArreaModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberAddressWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                 andAddress:(NSString *)address
                  andAreaId:(NSString *)aredId
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done{
    NSDictionary *parameter=[[NSDictionary alloc] initWithObjects:@[mid,secret,aredId,address] forKeys:@[@"mid",@"secret",@"area",@"address"]];
    [SharedAction postNoImage:Member_Address_URL parameters:parameter withCompletion:^(BOOL completion,NSDictionary *info){
        StatusModel *model =[[StatusModel alloc] initWithDictionary:info error:nil];
        [SharedAction commonActionWithUrl:Member_Address_URL andStatus:model.status andError:model.msg andJSONModelError:nil andObject:model withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberHeadWithMid:(NSString *)mid
               andSecret:(NSString *)secret
            andHeadImage:(UIImage *)headImage
      withViewController:(UIViewController *)viewcontroller
                withDone:(doneWithObject)done{
    NSDictionary *parameter=[[NSDictionary alloc] initWithObjects:@[mid,secret] forKeys:@[@"mid",@"secret"]];
    [SharedAction postOneImage:Member_Head_img_URL parameters:parameter name:@"head_image" image:headImage withCompletion:^(BOOL completion,NSDictionary *info){
        StatusModel *model =[[StatusModel alloc] initWithDictionary:info
                                                              error:nil];
        done(model);
//        [SharedAction commonActionWithUrl:Member_Head_img_URL andStatus:model.status andError:model.msg andJSONModelError:nil andObject:model.info withDone:done];
    }];
}

-(void)memberwithViewController:(UIViewController *)viewcontroller AboutWithDone:(doneWithObject)done {
    [StatusModel getModelFromURLWithString:Member_About_URL completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:Member_About_URL andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];
}

-(void)memberwithViewController:(UIViewController *)viewcontroller ContactWithDone:(doneWithObject)done{
    [StatusModel getModelFromURLWithString:Member_Contact_URL completion:^(StatusModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:Member_Contact_URL andStatus:model.status andError:model.msg andJSONModelError:error andObject:model.info withViewController:viewcontroller withDone:done];
    }];
}
-(void)memberSignWithMid:(NSString *)mid
               andSecret:(NSString *)secret
      withViewController:(UIViewController *)viewcontroller
                withDone:(doneWithObject)done{
     NSString *urlString =[NSString stringWithFormat:Member_Sign_URL ,mid,secret];
    [PointModel getModelFromURLWithString:urlString completion:^(PointModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString andStatus:model.status andError:model.msg andJSONModelError:error andObject:model withViewController:viewcontroller withDone:done];
    }];
}
-(void)memberAuditWithMid:(NSString *)mid
                andSercet:(NSString *)secret
              andRealName:(NSString *)realName
                andCardNo:(NSString *)cardNo
             andCardImage:(UIImage*)cardImage
             andStoreName:(NSString *)storeName
            andStoreImage:(UIImage *)storeImage
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done {
    NSDictionary *parament;
    if (cardImage==nil||storeImage==nil) {
        parament=[[NSDictionary alloc] initWithObjects:@[mid,secret,realName,cardNo,storeName] forKeys:@[@"mid",@"secret",@"real_name",@"card_no",@"store_name"]];
        [SharedAction postNoImage:Member_Audit_URL parameters:parament withCompletion:^(BOOL completion,NSDictionary *info){
            StatusModel *model =[[StatusModel alloc] initWithDictionary:info
                                                                  error:nil];
            [SharedAction commonActionWithUrl:Member_Audit_URL
                                    andStatus:model.status
                                     andError:model.msg andJSONModelError:nil
                                    andObject:model
                           withViewController:viewcontroller
                                     withDone:done];
        }];
    }else{
        parament=[[NSDictionary alloc] initWithObjects:@[mid,secret] forKeys:@[@"mid",@"secret"]];
        NSArray *imageArray=@[cardImage,storeImage];
        NSArray *nameArray =@[@"card_image",@"store_image"];
        [SharedAction postImageArray:Member_Audit_URL parameters:parament name:nameArray imageArray:imageArray withCompletion:^(BOOL completion,NSDictionary *info){
            StatusModel *model =[[StatusModel alloc] initWithDictionary:info
                                                                  error:nil];
            [SharedAction commonActionWithUrl:Member_Audit_URL
                                    andStatus:model.status
                                     andError:model.msg andJSONModelError:nil
                                    andObject:model
                           withViewController:viewcontroller
                                     withDone:done];
        }];
    }
   
}
-(void)memberRefWithMid:(NSString *)mid
              andSecret:(NSString *)secret
                andPage:(NSString *)page
            andPageSize:(NSString *)pageSize
     withViewController:(UIViewController *)viewcontroller
               withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Member_Ref_URL ,mid,secret,page,pageSize];
    [RefModel getModelFromURLWithString:urlString completion:^(RefModel *model,JSONModelError *error){
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model.info
                       withViewController:viewcontroller
                                 withDone:done];
    }];
}


-(void)memeberMesageWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                    andPage:(NSString *)page
                andPageSize:(NSString *)pageSize
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done{
    NSString *urlString =[NSString stringWithFormat:Memeber_Mesage_URL,mid,secret,page,pageSize];
    [MemberMessageModel getModelFromURLWithString:urlString completion:^(MemberMessageModel *model ,JSONModelError *error){
    [SharedAction commonActionWithUrl:urlString
                            andStatus:model.status
                             andError:model.msg
                    andJSONModelError:error
                            andObject:model.info
                   withViewController:viewcontroller
                             withDone:done];
    }];
}
@end
