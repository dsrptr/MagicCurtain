//
//  RecodeDetailModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RecodeDetailModel<NSObject>
@end

@interface RecodeDetailModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *lesson_id;
@property(nonatomic,strong)NSString<Optional> *block_type;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@property(nonatomic,strong)NSString<Optional> *block_name;
@property(nonatomic,strong)NSString<Optional> *title;
@end
