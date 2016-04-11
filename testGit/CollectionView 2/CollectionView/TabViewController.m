//
//  TabViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "TabViewController.h"
#import "NewViewController.h"
#import "RankViewController.h"
#import "SongsListViewController.h"
#import "YourOwnViewController.h"
#import "NavViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChild];
    self.view.backgroundColor = [UIColor colorWithRed:167.0/255.0 green:143.0/255.0 blue:195.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view.
}

-(void)addChild{
    NewViewController *new = [[NewViewController alloc] init];
    [self addChildViewController:new WithTitle:@"新歌首发" image:@"newsongs"];
    
    RankViewController *rank = [[RankViewController alloc] init];
    [self addChildViewController:rank WithTitle:@"排行榜" image:@"ranksongs"];
    
    SongsListViewController *slist = [[SongsListViewController alloc] init];
    [self addChildViewController:slist WithTitle:@"歌单" image:@"listsongs"];
    
    YourOwnViewController *yours = [[YourOwnViewController alloc] init];
    [self addChildViewController:yours WithTitle:@"私人定制" image:@"yoursongs"];
}

-(void)addChildViewController:(UIViewController *)childController  WithTitle:(NSString *)title image:(NSString *)imageName{
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.title = title;
    
    NavViewController *nav = [[NavViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
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
