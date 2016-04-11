//
//  DataModel.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/4.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel



+(NSArray *)getModelDataArray:(NSString *)plist{
    NSString *path = [[NSBundle mainBundle] pathForResource:plist ofType:nil];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic  in dataArr) {
        DataModel *model = [DataModel titleModelWithDictionary:dic];
        [arr addObject:model];
        
    }
    return arr.copy;
}

+(instancetype)titleModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
