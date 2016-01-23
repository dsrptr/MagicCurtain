//
//  LessonIndexModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/27.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "LessonInfoModel.h"
#import "LessonTypeInfoModel.h"

@interface LessonIndexModelInfo : JSONModel
@property(nonatomic,strong)NSArray<LessonTypeInfoModel,Optional> *lesson_type;
@property(nonatomic,strong)NSArray<LessonInfoModel,Optional> *lesson;
@end

@interface LessonIndexModel : JSONModel
@property(nonatomic,strong)LessonIndexModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
