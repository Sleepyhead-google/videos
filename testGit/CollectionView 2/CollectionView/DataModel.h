//
//  DataModel.h
//  CollectionView
//
//  Created by 张娟娟 on 16/4/4.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

-(void)getModelDataArray:(NSString *)plist;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
+(instancetype)titleModelWithDictionary:(NSDictionary *)dic;

@end
