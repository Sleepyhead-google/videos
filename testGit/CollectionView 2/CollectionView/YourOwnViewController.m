//
//  YourOwnViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "YourOwnViewController.h"
#import "VideoViewController.h"

@interface YourOwnViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UISearchBar *search;
    NSArray *arr;
    UITableView *tableview;
    UIImageView *imgView;
    UIScrollView *scrollView;
    NSArray *dataSource;
    UIPageControl *pagec;
    
}

@end

@implementation YourOwnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    search = [[UISearchBar alloc]init];
    search.placeholder = @"搜你喜欢的歌";
    self.navigationItem.titleView = search;
    
    dataSource = @[@"美文读物",@"音乐故事",@"情感调频",@"有声小说",@"人文历史",@"外语世界",@"娱乐|影视",@"旅途|城市",@"3D|电子",@"校园|教育",@"亲子宝贝",@"广播剧",@"相声曲艺",@"二次元",@"明星做主播",@"脱口秀",@"创作|翻唱"];
    

    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];

    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    self.navigationItem.leftBarButtonItems = @[back];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:pan];

    arr = @[@"2",@"1",@"2",@"1",@"2"];
    self.navigationController.navigationBar.translucent = NO;
    [self createScrollViewDown];
    
    pagec = [[UIPageControl alloc] initWithFrame:CGRectMake(scrollView.frame.size.width/2-50, 420, 100, 40)];
    pagec.pageIndicatorTintColor = [UIColor whiteColor];
    pagec.currentPageIndicatorTintColor = [UIColor greenColor];
    pagec.numberOfPages = arr.count;
    pagec.currentPage = 0;
    [self.view addSubview:pagec];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (mycell == nil) {
        mycell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

    mycell.textLabel.text = dataSource[indexPath.row];
    

    return mycell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"next");
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    [self.navigationController pushViewController:videoVC animated:YES];
}



-(void)createScrollViewDown{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-100)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*arr.count, 0);
    [self.view addSubview:scrollView];
    
    
    for (int i=0; i<arr.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(150+CGRectGetWidth(self.view.frame)*i-50, 80, 100, 100)];
        lb.text = arr[i];
        lb.font = [UIFont systemFontOfSize:30];
        lb.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:lb];
        UIImageView *iview = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        iview.image = [UIImage imageNamed:arr[i]];
        iview.contentMode = UIViewContentModeScaleToFill;
        [scrollView addSubview:iview];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultValue:) name:@"111" object:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)defaultValue:(NSNotification *)notification{
    NSString *str = [notification object];
    CGFloat temp = [str intValue];
    scrollView.contentOffset = CGPointMake(temp*CGRectGetWidth(self.view.frame), 0);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [search resignFirstResponder];
}


-(void)hideKeyboard{
    [search resignFirstResponder];
}
-(void)backBtnClick{
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.3 animations:^{
        searchBar.showsCancelButton = YES;
    }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
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
