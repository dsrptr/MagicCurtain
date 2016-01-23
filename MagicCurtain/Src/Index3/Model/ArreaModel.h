//
//  ArreaModel.h
//  MagicCurtain
//
//  Created by macbook pro on 15/12/9.
//  Copyright © 2015年 com.honglangya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ArreaModelProvinceInfo <NSObject>

@end
@interface ArreaModelProvinceInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *province;
@property(nonatomic,strong)NSString<Optional> *province_name;
@end

@protocol ArreaModelCityInfo <NSObject>

@end
@interface ArreaModelCityInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *city;
@property(nonatomic,strong)NSString<Optional> *city_name;
@end

@protocol ArreaModelAreaInfo <NSObject>

@end
@interface ArreaModelAreaInfo : JSONModel
@property(nonatomic,strong)NSString<Optional> *area;
@property(nonatomic,strong)NSString<Optional> *area_name;
@end

@interface ArreaModelInfo : JSONModel
@property(nonatomic,strong)NSArray<ArreaModelProvinceInfo,Optional> *province;
@property(nonatomic,strong)NSArray<ArreaModelCityInfo,Optional> *city;
@property(nonatomic,strong)NSArray<ArreaModelAreaInfo,Optional> *area;
@end
@interface ArreaModel : JSONModel
@property(nonatomic,strong)ArreaModelInfo<Optional> *info;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,strong)NSString<Optional> *msg;
@end
