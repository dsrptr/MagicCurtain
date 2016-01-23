//
//  LoginModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginModel : JSONModel
/**
*     用户id
 */
@property(nonatomic,strong)NSString <Optional>*mid;
/**
*     用户登录名
 */
@property(nonatomic,strong)NSString <Optional>*login_name;
/**
*     用户手机号码
 */
@property(nonatomic,strong)NSString <Optional>*mobile;
/**
*     用户真实姓名
 */
@property(nonatomic,strong)NSString <Optional>*real_name;
/**
*     用户昵称
 */
@property(nonatomic,strong)NSString <Optional>*nick_name;
/**
*     用户头像
 */
@property(nonatomic,strong)NSString <Optional>*head_image;
/**
*     用户性别
 */
@property(nonatomic,strong)NSString <Optional>*sex_name;
/**
*     用户等级
 */
@property(nonatomic,strong)NSString <Optional>*member_level;
/**
*     用户等级名称
 */
@property(nonatomic,strong)NSString <Optional>*member_level_name;
/**
*     用户积分
 */
@property(nonatomic,assign)NSInteger point;
/**
*    用户密钥
 */
@property(nonatomic,strong)NSString <Optional>*secret;
/**
 *    身份证号码
 */
@property(nonatomic,strong)NSString <Optional>*card_no;
/**
 *    用户照片
 */
@property(nonatomic,strong)NSString <Optional>*card_image;
/**
 *    店铺名称
 */
@property(nonatomic,strong)NSString <Optional>*store_name;
/**
 *    身份id
 
 */
@property(nonatomic,assign)NSInteger province;
/**
 *    省份名称
 */
@property(nonatomic,strong)NSString <Optional>*province_name;
/**
 *    城市id
 */
@property(nonatomic,assign)NSInteger city;
/**
 *    城市名称
 */
@property(nonatomic,strong)NSString <Optional>*city_name;
/**
 *    地区id
 
 */
@property(nonatomic,assign)NSInteger area;
/**
 *    地区名称
 
 */
@property(nonatomic,strong)NSString <Optional>*area_name;
/**
 *    街道地址
 
 */
@property(nonatomic,strong)NSString <Optional>*address;
/**
 *是否已认证
 
 */
@property(nonatomic,assign)NSInteger member_audit;

@property(nonatomic,strong)NSString <Optional>*store_image;
@end
