//
//  PointModel.h
//  MagicCurtain
//
//  Created by macbook pro on 16/1/4.
//  Copyright © 2016年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface PointModelInfo : JSONModel
@property(nonatomic,assign)NSInteger point;
@end
@interface PointModel : JSONModel
@property(nonatomic,strong)PointModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
