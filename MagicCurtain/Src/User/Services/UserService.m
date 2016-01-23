//
//  UserService.m
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import "UserService.h"
#import <JSONModelLib.h>
#import "VerifyModel.h"
#import "LoginModel.h"
#import "RegistModel.h"
#import "StatusModel.h"
#import "MyMD5.h"
#define Member_Regist_URL [BaseUrl stringByAppendingString:@"Member/member_regist/mobile/%@/verify_code/%@/invite_code/%@/password/%@"]
#define Verify_Code_URL [BaseUrl stringByAppendingString:@"Member/verify_code/mobile/%@/"]
#define MemberLogin_URL [BaseUrl stringByAppendingString:@"Member/member_login/login_name/%@/password/%@/channel_id/%@/frome/IOS"]
#define MemberPassword_forget_URL [BaseUrl stringByAppendingString:@"Member/password_forget/mobile/%@/password/%@/verify_code/%@"]
@implementation UserService

-(void)memberRegistWithmobile:(NSString *)mobile
                  andPassword:(NSString *)password
                  andPassword2:(NSString *)password2
                andVerifyCode:(NSString *)verify_code
                andInviteCode:(NSString *)invite_code
        withViewController:viewcontroller
               withDone:(doneWithObject)done{
    if ([self validateRegistInfosWithName:mobile
                           andVerify_code:verify_code
                              andPassword:password
                             andPassword2:password2]) {
        
    NSString *passwords = [MyMD5 md5:password];
    NSString *urlString =[NSString stringWithFormat:Member_Regist_URL,mobile,verify_code,invite_code,passwords];
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
}

-(void)verifyCodeWithMobile:(NSString *)mobile
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done{
//    if (mobile.length!=11) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码!"];
//        return;
//    }
    [SVProgressHUD show];
    NSString *urlString =[NSString stringWithFormat:Verify_Code_URL,mobile];
    [VerifyModel getModelFromURLWithString:urlString
                                completion:^(VerifyModel *model,JSONModelError *error){
                [SharedAction commonActionWithUrl:urlString
                                        andStatus:model.status
                                         andError:model.msg
                                andJSONModelError:error
                                        andObject:model
                               withViewController:viewcontroller
                                         withDone:done];
    
    }];
}

-(void)memberLoginwithLoginName:(NSString *)login_name
                    andPassword:(NSString *)password
                  andChannel_id:(NSString *)channel_id
             withViewController:(UIViewController*)viewcontroller
                       withDone:(doneWithObject)done{
    [SVProgressHUD show];
    if ([self validateLoginInfosWithName:login_name andPasswd:password]) {
    NSString *passwords = [MyMD5 md5:password];
    NSString *urlString =[NSString stringWithFormat:MemberLogin_URL,login_name,passwords,channel_id];
    [StatusModel getModelFromURLWithString:urlString completion:^(StatusModel *model,JSONModelError *error){
        if (model.status==2) {
            StatusModelInfo *models =model.info;
            [self setUserDataWith:models.member andLoginName:login_name andPassword:password];
        }
        [SharedAction commonActionWithUrl:urlString
                                andStatus:model.status
                                 andError:model.msg
                        andJSONModelError:error
                                andObject:model
                       withViewController:viewcontroller
                                 withDone:done];
    }];
    }
}

-(void)passwordForgetwith:(NSString *)mobile
           andVerify_code:(NSString *)verify_code
              andPassword:(NSString *)password
         andPasswordAgain:(NSString *)passwordagain
       withViewController:(UIViewController*)viewcontroller
                withDonel:(doneWithObject)done{
    if ([self validateRegistInfosWithName:mobile andVerify_code:verify_code andPassword:password andPassword2:passwordagain]) {
        NSString *urlString =[NSString stringWithFormat:MemberPassword_forget_URL,mobile,[MyMD5 md5:password],verify_code];
        [StatusModel getModelFromURLWithString:urlString
                                    completion:^(StatusModel *model,JSONModelError *error){
                                        [SharedAction commonActionWithUrl:urlString
                                                                andStatus:model.status
                                                                 andError:model.msg
                                                        andJSONModelError:error
                                                                andObject:model
                                                       withViewController:viewcontroller
                                                                 withDone:done];
                                    }];

    }
   
}
//设置用户信息
-(void)setUserDataWith:(LoginModel*)model
          andLoginName:(NSString *)loginName
           andPassword:(NSString *)password{
    SharedData *sharedData =[SharedData sharedInstance];
    sharedData.loginStatus=@"YES";
    sharedData.user=model;
    sharedData.loginname=loginName;
    sharedData.password=password;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginSuccess" object:nil];
}
//验证登录
-(BOOL)validateLoginInfosWithName:(NSString *)name andPasswd:(NSString *)passwd{
    if ([name isEqualToString:@""]||name==nil) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return false;
    }else if([passwd isEqualToString:@""]||passwd==nil){
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return false;
    }else{
        return true;
    }
}
//验证注册
-(BOOL)validateRegistInfosWithName:(NSString *)name
                    andVerify_code:(NSString *)verify_code
                       andPassword:(NSString *)password
                      andPassword2:(NSString*)password2{
    if ([name isEqualToString:@""]||name==nil) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return false;
    }else if([verify_code isEqualToString:@""]||verify_code==nil||verify_code.length!=4){
        [SVProgressHUD showErrorWithStatus:@"验证码输入有误"];
        return false;
    }else if([password2 isEqualToString:@""]||[password isEqualToString:@""]||password2==nil||password==nil||password2.length<6||password.length<6){
        [SVProgressHUD showErrorWithStatus:@"密码不能小于6位"];
        return false;
    }else if([password2 isEqualToString:password]){
        return true;
    }else{
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不相同"];
        return false;
    }
}
@end
