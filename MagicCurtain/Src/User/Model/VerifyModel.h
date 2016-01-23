//
//  VerifyModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/21.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VerifyModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*msg;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString <Optional>*info;
@end
