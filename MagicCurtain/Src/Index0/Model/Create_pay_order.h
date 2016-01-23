//
//  Create_pay_order.h
//  Club
//
//  Created by Gao Huang on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "JSONModel.h"

@interface Create_pay_orderInfo : JSONModel
@property(nonatomic,strong)NSString *out_trade_no;
@property(nonatomic,strong)NSString *default_partner;
@property(nonatomic,strong)NSString *default_seller;
@property(nonatomic,strong)NSString *private;
@property(nonatomic,strong)NSString *notify_url;
@property(nonatomic,strong)NSString *total_fee;
@end

@interface Create_pay_order : JSONModel
@property(nonatomic,strong)Create_pay_orderInfo <Optional>*info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString *msg;
@end
