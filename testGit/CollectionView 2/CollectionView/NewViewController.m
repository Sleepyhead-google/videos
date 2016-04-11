//
//  NewViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "NewViewController.h"
#import "TableViewCell.h"

@interface NewViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *dataArr;
    NSArray *detailArr;
    TableViewCell *tbcell;
    
    UIScrollView *sview;
    UIPageControl *pagec;
    NSTimer *timer;
    NSArray *imgArr;
    BOOL flag;
}
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tbview = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tbview.delegate = self;
    tbview.dataSource = self;
    [self.view addSubview:tbview];
    
    
    dataArr = [NSArray arrayWithObjects:@"走進阿拉伯，感受中東異域風情",@"世界上最好听的钢琴曲没有之一",@"『视觉/小说』你所不知道的纯音殿堂", nil];
    detailArr = [NSArray arrayWithObjects:@"简介： 二次元虽然不是真实的，",@"简介： 歌单包含某科学的超电磁炮两季&OVA&剧场版内OP&ED&OST&PSP游戏主题曲&副歌&插入曲&角色歌&广播&伴奏。歌：1-26，广播：27-32，伴奏：33-47，OST：48-124。",@"简介： 视觉小说，是冒险游戏中分支游戏类型之一。可以将视觉小说理解为电子书，但作为一种新生的艺术形式，视觉小说集合了游戏系统+戏剧架构+文学+绘画CG+音乐多种艺术及设计形式，远比纯文字的电子书丰富。", nil];
    
    
    imgArr = [NSArray arrayWithObjects:@"0",@"0",@"0", nil];
    
    sview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    sview.directionalLockEnabled = YES;
    sview.showsHorizontalScrollIndicator = NO;
    sview.showsVerticalScrollIndicator = NO;
    sview.pagingEnabled = YES;

    
    [sview setContentSize:CGSizeMake(CGRectGetWidth(sview.frame)*imgArr.count, 200)];

//    sview.contentSize = CGSizeMake(self.view.frame.size.width*3, 200);
    for (int i = 0; i < imgArr.count; i++) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame: CGRectMake(sview.frame.size.width*i, 0, sview.frame.size.width, 200)];
        imgview.image = [UIImage imageNamed:imgArr[i]];
        [sview addSubview:imgview];
    }
    [sview scrollRectToVisible:sview.bounds animated:YES];
    
    [self.view addSubview:sview];
    
    pagec = [[UIPageControl alloc] initWithFrame:CGRectMake(sview.frame.size.width/2-100, sview.frame.size.height-30, 200, 30)];

    pagec.numberOfPages = 2;
    pagec.currentPage = 0;
    pagec.pageIndicatorTintColor = [UIColor whiteColor];
    pagec.currentPageIndicatorTintColor = [UIColor greenColor];
    [pagec addTarget:self action:@selector(changepage:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:pagec];
    
    
    timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoscroll) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

-(void)autoscroll{
    pagec.currentPage ++;
    [sview setContentOffset:CGPointMake(sview.frame.size.width*pagec.currentPage, 0) animated:YES];
    if (flag) {
        [sview setContentOffset:CGPointMake(0, 0) animated:YES];
        pagec.currentPage = 0;
    }else{
        [sview setContentOffset:CGPointMake(sview.frame.size.width * pagec.currentPage, 0)];
    }
    if (pagec.currentPage < pagec.numberOfPages -1) {
        flag = NO;
    }else{
        flag = YES;
    }
}

-(void)loadScrollViewPage:(NSInteger)page{
    
}

-(void)changepage:(id)sender {
    [sview setContentOffset:CGPointMake(pagec.currentPage*sview.frame.size.width, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = floor((sview.contentOffset.x - pagec.frame.size.width/2)/sview.frame.size.width) + 1;
    
    pagec.currentPage = page;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tbcell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (tbcell == nil) {
        tbcell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        NSInteger num = [indexPath row];
        tbcell.textLabel.text = [dataArr objectAtIndex:num];
        tbcell.detailTextLabel.text = [detailArr objectAtIndex:num];
        
    }
    
    if (indexPath == 0) {
        
    }
    
    return tbcell;

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *arr = [NSArray arrayWithObjects:indexPath, nil];
        [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    tbcell.backgroundColor = [UIColor purpleColor];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}


//
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//}



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
