//
//  UserService.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject

/**
 
 注册 
 mobile            手机号
 verify_code       验证码
 invite_code       邀请码
 
 */

-(void)memberRegistWithmobile:(NSString *)mobile
                  andPassword:(NSString *)password
                 andPassword2:(NSString *)password2
                andVerifyCode:(NSString *)verify_code
                andInviteCode:(NSString *)invite_code
           withViewController:(UIViewController*)viewcontroller
                     withDone:(doneWithObject)done;

/**
 
 获取验证码
 mobile            手机号
 
*/

-(void)verifyCodeWithMobile:(NSString *)mobile
         withViewController:(UIViewController*)viewcontroller
                   withDone:(doneWithObject)done;
/**
 
 登陆
 mobile            登陆名
 password          密码
 channel_id        通道id
 
 */

-(void)memberLoginwithLoginName:(NSString *)login_name
                    andPassword:(NSString *)password
                  andChannel_id:(NSString *)channel_id
             withViewController:(UIViewController*)viewcontroller
                       withDone:(doneWithObject)done;


/**
 *  忘记密码修改密码
 *
 *  @param mobile        手机号
 *  @param verify_code   验证码
 *  @param password      输入密码
 *  @param passwordagain 确认密码
 *  @param done          回调函数
 */
-(void)passwordForgetwith:(NSString *)mobile
           andVerify_code:(NSString *)verify_code
              andPassword:(NSString *)password
         andPasswordAgain:(NSString *)passwordagain
       withViewController:(UIViewController*)viewcontroller
                withDonel:(doneWithObject)done;

@end
