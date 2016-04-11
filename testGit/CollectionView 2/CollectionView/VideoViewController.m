//
//  VideoViewController.m
//  CollectionView
//
//  Created by 张娟娟 on 16/4/7.
//  Copyright (c) 2016年 张娟娟. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Video.h"



@interface VideoViewController ()<AVAudioPlayerDelegate,AVCaptureFileOutputRecordingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    AVCaptureVideoPreviewLayer *preLayer;
    AVCaptureMovieFileOutput *output;
    UIImagePickerController *ipc;
}

@end



@implementation VideoViewController

+(UIImage *)imageOfVideo:(NSURL *)videoUrl{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0, 10);
    CMTime actualTime;
    CGImageRef img = [gen copyCGImageAtTime:time actualTime:&actualTime error:nil];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:img];
    CGImageRelease(img);
    return thumb;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
   
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 110, 150, 40);
    btn.layer.cornerRadius = 10.0;
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"播放视频" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(openMovie:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cbtn setTitle:@"录制视频" forState:UIControlStateNormal];
    cbtn.frame = CGRectMake(50, 220, 150, 40);
    cbtn.backgroundColor = [UIColor blueColor];
    cbtn.titleLabel.text = @"33";
    [cbtn addTarget:self action:@selector(recordVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbtn];
    
    [self makeVideoUI];
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:nil];
//    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    AVCaptureDeviceInput *inputAudio = [AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:nil];
//    
//    output = [[AVCaptureMovieFileOutput alloc] init];
//
//    
//    AVCaptureSession *senssion = [[AVCaptureSession alloc] init];
//    if ([senssion canAddInput:inputAudio]) {
//        [senssion addInput:inputAudio];
//    }
//    if ([senssion canAddInput:inputVideo]) {
//        [senssion addInput:inputVideo];
//    }
//    if ([senssion canAddOutput:output]) {
//        [senssion addOutput:output];
//    }
//    

    
    [self makeVideoImage];
    
    // Do any additional setup after loading the view.
}

-(UIImage *)makeVideoImage{
    NSURL *videoUrl = [NSURL URLWithString:@"http://www.w3school.com.cn/example/html5/mov_bbb.mp4"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0, 10);
    CMTime actualTime;
    CGImageRef img = [gen copyCGImageAtTime:time actualTime:&actualTime error:nil];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:img];
    CGImageRelease(img);
    return thumb;
}


-(void)makeVideoUI{
//    //1.创建视频设备(摄像头前，后)
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    //2.初始化一个摄像头输入设备(first是后置摄像头，last是前置摄像头)
//    AVCaptureDeviceInput *inputVideo =[AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];
//    //3.创建麦克风设备
//    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    //4.初始化麦克风输入设备
//    AVCaptureDeviceInput *inputAudio =[AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];
//    output = [[AVCaptureMovieFileOutput alloc] init];
////    output = output; //保存output，方便下面操作
//    AVCaptureSession *session =[[AVCaptureSession alloc] init];
//
//    if ([session canAddInput:inputVideo]) {
//         [session addInput:inputVideo];
//         }
//     if ([session canAddInput:inputAudio]) {
//         [session addInput:inputAudio];
//         }
//     if ([session canAddOutput:output]) {
//         [session addOutput:output];
//     }
//    
//     preLayer =[AVCaptureVideoPreviewLayer layerWithSession:session];
//     preLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:preLayer];
//    [session startRunning];
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;

    
}



-(void)recordVideo:(UIButton *)sender{
//    if ([output isRecording]) {
//        [output stopRecording];
//        [sender setTitle:@"ing" forState:UIControlStateNormal];
//        return;
//    }
//    [sender setTitle:@"stop" forState:UIControlStateNormal];
//    
//    [self performSelector:@selector(startRecording) withObject:nil afterDelay:1.0];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        ipc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        ipc.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }else{
        NSLog(@"cant");
    }
    [self presentViewController:ipc animated:YES completion:nil];


}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ( ipc.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *img = nil;
        if ([ipc allowsEditing]) {
            img = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            img = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }else{
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        ALAssetsLibrary *assetslib = [[ALAssetsLibrary alloc] init];
        [assetslib writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
          
        }];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [ipc dismissViewControllerAnimated:YES completion:nil];
}

-(void)startRecording{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"my.mov"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [output startRecordingToOutputFileURL:url recordingDelegate:self];
    
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"3");
}

-(void)openMovie:(id)sender{
    MPMoviePlayerViewController *movie = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/html5/mov_bbb.mp4"]];
    [movie.moviePlayer prepareToPlay];
//    movie.view.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview:movie.view];
    [self presentMoviePlayerViewControllerAnimated:movie];
    [movie.view setBackgroundColor:[UIColor redColor]];
    [movie.view setFrame:self.view.bounds];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finish:) name:MPMoviePlayerPlaybackDidFinishNotification object:movie.moviePlayer];
}
-(void)finish:(id)sender{
    
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
