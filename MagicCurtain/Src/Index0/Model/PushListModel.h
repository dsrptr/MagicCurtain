//
//  PushListModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/11/25.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol PushListModel<NSObject>
@end

@interface PushListModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *push_id;
@property(nonatomic,strong)NSString<Optional> *title;
@property(nonatomic,strong)NSString<Optional> *push_url;
@property(nonatomic,strong)NSString<Optional> *reg_time;
@property(nonatomic,strong)NSString<Optional> *is_read;
@property(nonatomic,strong)NSString<Optional> *demo;
@end
