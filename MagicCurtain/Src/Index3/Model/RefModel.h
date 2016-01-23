//
//  RefModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/19.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RefModelMemeberInfo<NSObject>
@end
@interface RefModelMemeberInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *mid;
@property(nonatomic,strong)NSString<Optional> *real_nam;
@property(nonatomic,strong)NSString<Optional> *mobile;
@property(nonatomic,strong)NSString<Optional> *reg_time;

@end
@interface RefModelInfo : JSONModel
@property(nonatomic,strong)NSArray<RefModelMemeberInfo,Optional> *memeber;
@end

@interface RefModel : JSONModel
@property(nonatomic,strong)RefModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
