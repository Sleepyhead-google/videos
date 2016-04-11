//
//  SongsListViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "SongsListViewController.h"
#import "CollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define oriColor [UIColor colorWithRed:100.0/255.0 green:10.0/255.0 blue:100.0/255.0 alpha:1.0]

@interface SongsListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSArray *songs;
    NSArray *songTitle;
    NSArray *songSrc;
    
    UIImageView *imgview;
    UILabel *text;
    CollectionViewCell *cell;
    CGFloat parWidth;
    CGFloat imgviewWidth;

}

@end

@implementation SongsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    songTitle = [NSArray arrayWithObjects:@"黄致列",@"Adele",@"BIGBANG",@"巴赫",@"赵传",@"齐秦",@"张信哲",@"Rihanna",@"P!nk",@"Beyoncé",@"Lady Gaga",@"那英", nil];

    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];

    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flow.minimumInteritemSpacing = 5;
    flow.minimumLineSpacing = 10;
    
    
    UICollectionView *cview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flow];
    cview.delegate = self;
    cview.dataSource = self;
    cview.backgroundColor = [UIColor whiteColor];

    [cview registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [cview registerClass:[CollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuseableview"];

    [self.view addSubview:cview];
    

   
    
    
    // Do any additional setup after loading the view.
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return songTitle.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    parWidth = cell.frame.size.width;
    cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, 70, 70)];
    text = [[UILabel alloc] initWithFrame:CGRectMake(25, 70, 70, 30)];
    text.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *imgname = [NSString stringWithFormat:@"%ld.png",indexPath.row];
    imgview.image = [UIImage imageNamed:imgname];

    text.text = [NSString stringWithFormat:@"%@",songTitle[indexPath.row]];
    
    [cell addSubview:text];
    [cell addSubview:imgview];
    
    [cell addSubview:[self getUrlImage]];
    
    [cell sizeToFit];
    cell.layer.cornerRadius = 10.0;
    cell.layer.borderWidth = 5.0;
    cell.layer.borderColor = (__bridge CGColorRef)([UIColor purpleColor]);

   
    
    return cell;
}





-(UIImageView *)getUrlImage{
    //    添加获取网络图片
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, imgviewWidth, 70)];
    NSArray *imgarr = [NSArray arrayWithObjects:@"http://c.hiphotos.baidu.com/image/h%3D300/sign=e11ae3db0e23dd543e73a168e108b3df/50da81cb39dbb6fd786f7a990e24ab18972b375c.jpg",@"",@"", nil];
    for (int i=0; i<imgarr.count; i++) {
        NSURL *url = [NSURL URLWithString:imgarr[i]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        imgview.image = img;
        NSLog(@"%p",imgarr[i]);
    }
    return imgview;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH/3-20, 100);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    cell.layer.borderColor = [UIColor colorWithRed:91.0/255.0 green:106.0/255.0 blue:109.0/255.0 alpha:1.0].CGColor;

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
}



-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
