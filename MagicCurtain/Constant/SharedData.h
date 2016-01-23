//
//  SharedData.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface SharedData : NSObject
/**
 *   用户信息
 */
@property(nonatomic,strong)LoginModel *user;
/**
 *   登陆名
 */
@property(nonatomic,strong)NSString *loginname;
/**
 *   登录密码
 */
@property(nonatomic,strong)NSString *password;
/**
 *   登录状态
 */
@property(nonatomic,strong)NSString *loginStatus;
/**
 *   是否第一次使用
 */
@property(nonatomic,strong)NSString *starStatus;
/**
*   是否开启指纹支付
 */
@property(nonatomic,strong)NSString *fingerIsOpened;
/**
 
 */
@property(nonatomic,strong)NSString *payPassword;//支付密码
/**
 
 */
@property(nonatomic,strong)NSString *channelId;
/**
 
 */
@property(nonatomic,strong)NSString *lessonId;
/**
 
 */
@property(nonatomic,strong)NSString *lessonType;
/**
 
 */
@property(nonatomic,strong)NSString *indexPath;
/**
 
 */
@property(nonatomic,strong)NSString *index;

@property(nonatomic,strong)NSString *device_token;
+(id)sharedInstance;
@end
