//
//  CalcResultModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/8.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//@interface calcCesultInfo : JSONModel
//@end

@interface CalcResultModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *calc_id;
@property(nonatomic,strong)NSDictionary<Optional> *calc_result;
@end
@interface CalcResultModel : JSONModel
@property(nonatomic,strong)CalcResultModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
