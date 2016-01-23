//
//  SeachResultModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LessonInfoModel.h"


@interface SeachResultModelInfo : JSONModel
@property(nonatomic,strong)NSArray <LessonInfoModel,Optional> *lesson;
@property(nonatomic,strong)NSArray <LessonInfoModel,Optional>*cases;
@end
@interface SeachResultModel : JSONModel
@property(nonatomic,strong)SeachResultModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
