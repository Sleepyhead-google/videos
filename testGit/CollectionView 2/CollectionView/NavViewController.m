//
//  NavViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/3.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "NavViewController.h"
#define navColor [UIColor colorWithRed:167.0/255.0 green:143.0/255.0 blue:195.0/255.0 alpha:1.0]

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.barTintColor = navColor;
    
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:YES];
    [self addbackBtn:viewController];
}
-(void)addbackBtn:(UIViewController *)viewController{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbtn"] style:UIBarButtonItemStylePlain target:self action:@selector(btnclick)];
    viewController.navigationItem.leftBarButtonItems = @[back];
}

-(void)btnclick{
    [self popViewControllerAnimated:YES];
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
