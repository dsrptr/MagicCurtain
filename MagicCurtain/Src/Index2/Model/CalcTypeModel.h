//
//  CalcTypeModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/7.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol CalcTypeModelCalc_TypeInfo<NSObject>
@end

@protocol InputInfo<NSObject>
@end

@interface InputInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *item;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *prompt;
@end

@interface CalcTypeModelCalc_TypeInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *calc_id;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSArray <InputInfo,Optional> *input;
@property(nonatomic,strong)NSArray <InputInfo,Optional> *out;
@end
@interface CalcTypeModelInfo : JSONModel
@property(nonatomic,strong) NSArray <CalcTypeModelCalc_TypeInfo,Optional> *calc_type;
@end
@interface CalcTypeModel : JSONModel
@property(nonatomic,strong)CalcTypeModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
