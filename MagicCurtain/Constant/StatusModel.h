//
//  StatusModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LoginModel.h"
#import "VerifyModel.h"
#import "PushListModel.h"

@interface StatusModelInfo : JSONModel
@property(nonatomic,strong)LoginModel<Optional>*member;
@property(nonatomic,strong)NSArray <PushListModel,Optional>*push;
@property(nonatomic,strong)NSString<Optional> *about_url;
@property(nonatomic,strong)NSString<Optional> *phone;
@property(nonatomic,strong)NSString<Optional> *head_image;
@end

@interface StatusModel : JSONModel
@property(nonatomic,strong)StatusModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
