//
//  RankViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "RankViewController.h"
#import "ViewOne.h"
#import "ViewTwo.h"
#import "RankTableViewCell.h"
#import "MusicOneViewController.h"
#define curColor [UIColor colorWithRed: (135./255.0 ) green: (50.0/255.0) blue: (66.0/255.0) alpha:1.0]

@interface RankViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    NSArray *tbviewCount;
    NSArray *detailArr;
    UITableView *tbview;
    UILabel *rightlb;
    UILabel *leftlb;
}
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    tbviewCount = [NSArray arrayWithObjects:@"Beatport全球电子舞曲榜",@"KTV唛榜",@"iTunes榜",@"韩国Melon排行榜周榜", nil];

    detailArr = [NSArray arrayWithObjects:@"简介： Beatport全球电子舞曲排行榜TOP20（本榜每周四更新）",@"简介： KTV唛榜是目前国内首个以全国超过200家KTV点歌平台真实数据的当红歌曲榜单。所涉及的KTV店铺覆盖全国近100多个城市，囊括一、二、三线各级城市及地区。在综合全国各地KTV点唱数据的前提下进行汇总与统计。为了保证信息的及时性，唛榜每周五更新。提供给K迷们最新和最准确的数据。",@"detailArr",@"简介： 中国TOP排行榜分成内地榜及港台榜，每周一更新。", nil];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, CGRectGetWidth(self.view.frame), 400)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*2, 400);
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < tbviewCount.count; i++) {
        tbview = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        tbview.dataSource = self;
        tbview.delegate = self;

        [scrollView addSubview:tbview];
    }

    // Do any additional setup after loading the view.
}


-(void)makeUI{
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
//    self.navigationItem.leftBarButtonItem = left;
//    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"head" style:UIBarButtonItemStyleDone target:self action:@selector(goForward)];
//    self.navigationItem.rightBarButtonItem = right;
    
    leftlb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100, 80, 100, 40)];
    leftlb.text = @"官方榜";
//    leftlb.layer.borderColor = [UIColor redColor].CGColor;
//    leftlb.layer.borderWidth = 5.0;
    leftlb.backgroundColor = curColor;
    leftlb.textColor = [UIColor whiteColor];
    leftlb.textAlignment = NSTextAlignmentCenter;
    leftlb.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    [leftlb addGestureRecognizer:tap];
    [self.view addSubview:leftlb];
    rightlb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2, 80, 100, 40)];
    rightlb.text = @"全球榜";
    rightlb.userInteractionEnabled = YES;
    rightlb.backgroundColor = [UIColor whiteColor];
    rightlb.textColor = curColor;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goForward)];
    [rightlb addGestureRecognizer:tap1];
    rightlb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightlb];
    

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tbviewCount.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankTableViewCell *cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSInteger num = [indexPath row];
    for (int i = 0; i < tbviewCount.count; i++) {
        cell.textLabel.text = tbviewCount[num];
        cell.detailTextLabel.text = detailArr[num];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *color = (indexPath.row%2 == 0) ? [UIColor whiteColor] : [UIColor colorWithRed:224.0/255.0 green:228.0/255.0 blue:247.0/255.0 alpha:1.0];
    UIColor *txtcolor = (indexPath.row%2 == 0) ? [UIColor blackColor] : [UIColor purpleColor];
    cell.backgroundColor = color;
    cell.textLabel.textColor = txtcolor;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tbviewCount.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicOneViewController *musicone = [[MusicOneViewController alloc] init];
    musicone.title = @"林宥嘉";
    NSMutableArray *musics = [[NSMutableArray alloc] initWithObjects:musicone,musicone, nil];
    for (int i=0; i<tbviewCount.count; i++) {
        [musics addObject:musicone];
        
        NSLog(@"%ld",(long)musics.count);
    }

    [self.navigationController pushViewController:musics[indexPath.row] animated:YES];
    
}

-(void)goBack{
    NSLog(@"3");

    leftlb.backgroundColor = curColor;
    leftlb.textColor = [UIColor whiteColor];
    rightlb.backgroundColor = [UIColor whiteColor];
    rightlb.textColor = curColor;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)goForward{
    NSLog(@"33");
    rightlb.textColor = [UIColor whiteColor];
    rightlb.backgroundColor = curColor;
    leftlb.textColor = curColor;
    leftlb.backgroundColor = [UIColor whiteColor];

    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame), 0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)titleModelArray{
    if (titleModelArray == nil) {
        titleModelArray = [[NSArray alloc] init];
    }
    return  titleModelArray;
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
