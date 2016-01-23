//
//  Index2Service.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/7.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index2Service : NSObject
/**
 
 根据mid和secret获取计算类型
 mid                用户id
 secret             密钥 登录时返回
 
  */
-(void)calctypeWithMid:(NSString *)mid
             andSecret:(NSString *)secret
    withViewController:(UIViewController *)viewcontroller
              withDone:(doneWithObject)done;

/**
 
 获取计算结果
 mid                用户id
 secret             密钥 登录时返回
 calcid             计算类型id
 input              输入项
 
 */
-(void)calcCalcWithMid:(NSString *)mid
             andSecret:(NSString *)secret
             andCalcid:(NSString *)calcid
              andInput:(NSString*)input
    withViewController:(UIViewController *)viewcontroller
              withDone:(doneWithObject)done;

/**
 
 获取画图页面
 mid                用户id
 secret             密钥 登录时返回
 calcid             计算类型id
 input              输入项
 
 */
-(void)calcDrawWithMid:(NSString *)mid
             andSecret:(NSString *)secret
            andCalc_id:(NSString *)calc_id
              andInput:(NSString*)input
    withViewController:(UIViewController *)viewcontroller
              withDone:(doneWithObject)done;



@end
