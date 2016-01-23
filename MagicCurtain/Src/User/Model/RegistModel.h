//
//  RegistModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/24.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RegistModelInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *mid;
@property(nonatomic,strong)NSString<Optional> *mobile;
@end
@interface RegistModel : JSONModel
@property(nonatomic,strong)RegistModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
