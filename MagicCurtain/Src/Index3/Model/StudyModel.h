//
//  StudyModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RecodeDetailModel.h"

@interface StudyModelInfo : JSONModel
@property(nonatomic,strong)NSArray<RecodeDetailModel,Optional> *study;
@property(nonatomic,strong)NSArray<RecodeDetailModel,Optional> *collect;
@property(nonatomic,strong)NSArray<RecodeDetailModel,Optional> *share;
@property(nonatomic,strong)NSArray<RecodeDetailModel,Optional> *lesson;

@end

@interface StudyModel : JSONModel
@property(nonatomic,strong)StudyModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
