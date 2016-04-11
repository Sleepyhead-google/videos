//
//  MusicOneViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/7.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "MusicOneViewController.h"
#import <AVFoundation/AVFoundation.h>
#define btnCount 3
#define FILE_PATH @"/Users/zhangjuanjuan/node_modules/gulp-jshint/node_modules/jshint/node_modules/exit/test/fixtures/10-stderr.txt"

@interface MusicOneViewController (){
    AVAudioPlayer *player;
    NSInteger btntag;
    UIButton *btn;
    UIImageView *imgview;
    CGFloat angle;
    CADisplayLink *timer;
    NSString *lrc;
   
    
}

@end

@implementation MusicOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 这个是uinavigationcontroller的viewdidload中
    self.view.backgroundColor = [UIColor whiteColor];

 
//    //创建一个导航栏
//    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 44)];
//    //创建一个导航栏集合
//    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
//
//    [navigationItem setTitle:@"世界"];
//    //把导航栏集合添加入导航栏中，设置动画关闭
//    [navigationBar pushNavigationItem:navigationItem animated:NO];
//
//    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(gobackpage)];
//    
//    //把导航栏添加到视图中
//    [self.view addSubview:navigationBar];

    UILabel *singer = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.frame), 44)];
    singer.text = @"歌名：我爱的人";
    singer.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:singer];
    
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, 60+singer.frame.size.height, 100, 100)];
    UIImage *musicLogo = [UIImage imageNamed:@"musicone"];
    imgview.image = musicLogo;
    imgview.layer.cornerRadius = 50.0;
    imgview.layer.masksToBounds = YES;
    imgview.layer.borderColor = [UIColor whiteColor].CGColor;
    imgview.layer.borderWidth = 5.0;
    
    [self.view addSubview:imgview];
    
    [self addplaybtn];
   
    [self addplayer];
    
    

    
    // Do any additional setup after loading the view.
}

-(void)makeVideoUI{
   
    
    
}

-(void)gobackpage{
    
}



-(void)startRotating{
    if (timer) {
        return;
    }
    timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTimer)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateTimer{
    imgview.transform = CGAffineTransformRotate(imgview.transform, M_PI/200);
}

-(void)stopanim{
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"timer"];
    basicAnim.toValue = @(M_PI * 2 *5);
    basicAnim.duration = 2;
    basicAnim.delegate = self;
    basicAnim.fillMode = kCAFillModeForwards;
    basicAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [imgview.layer addAnimation:basicAnim forKey:nil];
    [self stopRotating];
}

-(void)stopRotating{
    [timer invalidate];
    timer = nil;
}

-(void)addplayer{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"baby.mp3" withExtension:nil];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
}

-(void)addplaybtn{
    NSArray *playbtn = [NSArray arrayWithObjects:@"play",@"pause",@"stop", nil];
    CGFloat btnW = self.view.frame.size.width/4;
    for (int i=0; i<btnCount; i++) {
        btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:playbtn[i] forState:UIControlStateNormal];
        btn.tintColor = [UIColor redColor];

        btn.frame = CGRectMake((btnW+30)*i+10, imgview.frame.size.height+130, btnW, 30);
        btn.layer.cornerRadius = 14.0;
        btn.layer.borderWidth = 1.0;
        btn.tag = i;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


-(void)touchbtn:(id)sender{
    btn.backgroundColor = [UIColor whiteColor];
    btn.tintColor = [UIColor redColor];
    UIButton *btn1 = (UIButton *)sender;
    btn1.backgroundColor = [UIColor redColor];
    btn1.tintColor = [UIColor whiteColor];
    switch (btn1.tag) {
        case 0:
            [self gotoplay];
            [self startRotating];

            break;
        case 1:
            [self gotopause:btn1];
            [self stopanim];
            break;
        case 2:
            [self gotostop];
            [self addplayer];
            [self stopanim];
            break;
            
        default:
            break;
    }
}

-(void)gotoplay{
    btn.backgroundColor = [UIColor whiteColor];
    btn.tintColor = [UIColor redColor];
    [player play];
    

}

-(void)gotopause:(UIButton *)btn1{
    
    btn.backgroundColor = [UIColor whiteColor];
    btn.tintColor = [UIColor redColor];
    btn1.backgroundColor = [UIColor redColor];
    btn1.tintColor = [UIColor whiteColor];
    [player pause];
}

-(void)gotostop{
    [player stop];
    player = Nil;
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
