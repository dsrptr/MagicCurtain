//
//  Index3Service.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/7.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index3Service : NSObject
/**
 根据课程分类获取收藏课程信息
 mid                用户id
 secret             密钥 登录时返回
 page               分页
 pageSize           每页数量
  */

-(void)memberCollectWithMid:(NSString *)mid
                  andSercet:(NSString *)sercet
                    andPage:(NSString *)page
                andPageSize:(NSString *)pageSize
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done;
/**
 根据课程分类获取分享列表
 mid                用户id
 secret             密钥 登录时返回
 page               分页
 pageSize           每页数量
 */

-(void)memberShareWithMid:(NSString *)mid
                andSercet:(NSString *)sercet
                  andPage:(NSString *)page
              andPageSize:(NSString *)pageSize
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done;
/**
 根据课程学习记录列表
 mid                用户id
 secret             密钥 登录时返回
 page               分页
 pageSize           每页数量
 */
-(void)memberStudyWithMid:(NSString *)mid
                andSercet:(NSString *)sercet
                  andPage:(NSString *)page
              andPageSize:(NSString *)pageSize
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done;

/**
 根据课程购买记录列表
 mid                用户id
 secret             密钥 登录时返回
 page               分页
 pageSize           每页数量
 */
-(void)memberBuyWithMid:(NSString *)mid
              andSercet:(NSString *)sercet
                andPage:(NSString *)page
            andPageSize:(NSString *)pageSize
     withViewController:(UIViewController *)viewcontroller
               withDone:(doneWithObject)done;

/**
 修改用户昵称
 mid                用户id
 secret             密钥 登录时返回
 nickName           用户昵称
 */
-(void)memberNickNameWithMid:(NSString *)mid
                   andSercet:(NSString *)sercet
                 andNIckName:(NSString *)nickName
          withViewController:(UIViewController *)viewcontroller
                    withDone:(doneWithObject)done;
/**
 修改用户名
 mid                用户id
 secret             密钥 登录时返回
 login_name         用户名
 */
-(void)loginNameWithMid:(NSString *)mid
              andSercet:(NSString *)secret
           andLoginName:(NSString *)login_name
     withViewController:(UIViewController *)viewcontroller
               withDone:(doneWithObject)done;
/**
 
获取省份信息
 mid                用户id
 secret             密钥 登录时返回
 
 */
-(void)memberProvinceWithMid:(NSString *)mid
                   andSecret:(NSString *)secret
                     andType:(NSInteger)type
                  andKeyWord:(NSString *)keyWord
          withViewController:(UIViewController *)viewcontroller
                    withDone:(doneWithObject)done;

/**
 
 修改地址
 mid                用户id
 secret             密钥 登录时返回
 address            详细地址信息
 aredId             地区id
 
 */
-(void)memberAddressWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                 andAddress:(NSString *)address
                  andAreaId:(NSString *)aredId
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done;

/**
 
 更新头像
 mid                用户id
 secret             密钥 登录时返回
 headImage          头像
 
 */

-(void)memberHeadWithMid:(NSString *)mid
               andSecret:(NSString *)secret
            andHeadImage:(UIImage *)headImage
      withViewController:(UIViewController *)viewcontroller
                withDone:(doneWithObject)done;


/**
关于我们
 */
-(void)memberwithViewController:(UIViewController *)viewcontroller
                  AboutWithDone:(doneWithObject)done ;


/**
 获取联系方式
 */
-(void)memberwithViewController:(UIViewController *)viewcontroller
                ContactWithDone:(doneWithObject)done;

/**
 
 每日签到
 mid                用户id
 secret             密钥 登录时返回
 
 */
-(void)memberSignWithMid:(NSString *)mid
               andSecret:(NSString *)secret
      withViewController:(UIViewController *)viewcontroller
                withDone:(doneWithObject)done;

/**
 
 实名认证
 mid                用户id
 secret             密钥 登录时返回
 realName           真实姓名
 cardNo             身份证号
 storeName          店铺名称
 storeImage         店铺照片
 
 */
-(void)memberAuditWithMid:(NSString *)mid
                andSercet:(NSString *)secret
              andRealName:(NSString *)realName
                andCardNo:(NSString *)cardNo
             andCardImage:(UIImage*)cardImage
             andStoreName:(NSString *)storeName
            andStoreImage:(UIImage *)storeImage
       withViewController:(UIViewController *)viewcontroller
                 withDone:(doneWithObject)done;

/**
 *  获取推荐人列表
 *
 *  @param mid      mid会员id
 *  @param secret   密钥
 *  @param page     分页
 *  @param pageSize 分页大笑
 *  @param done     回调函数
 */
-(void)memberRefWithMid:(NSString *)mid
              andSecret:(NSString *)secret
                andPage:(NSString *)page
            andPageSize:(NSString *)pageSize
     withViewController:(UIViewController *)viewcontroller
               withDone:(doneWithObject)done;
/**
 *  获取会员留言
 *
 *  @param mid      用户id
 *  @param secret   用户密钥
 *  @param page     分页
 *  @param pageSize 分页大小
 *  @param done     回调函数
 */
-(void)memeberMesageWithMid:(NSString *)mid
                  andSecret:(NSString *)secret
                    andPage:(NSString *)page
                andPageSize:(NSString *)pageSize
         withViewController:(UIViewController *)viewcontroller
                   withDone:(doneWithObject)done;
@end
