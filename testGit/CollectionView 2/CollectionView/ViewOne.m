//
//  ViewOne.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/4.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "ViewOne.h"

@implementation ViewOne


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"0"];
        [self addSubview:imgview];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
