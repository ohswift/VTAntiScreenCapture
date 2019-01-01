//
//  SimpleDRMVC.m
//  VCAntiScreenCapture_Example
//
//  Created by Vincent on 2018/12/31.
//  Copyright © 2018 mightyme@qq.com. All rights reserved.
//

#import "SimpleDRMVC.h"
#import "GCDWebServer.h"
#import "GCDWebServerFileResponse.h"
#import "VTSimplePlayer.h"
#import "AFNetworking.h"

@interface SimpleDRMVC ()

@property (nonatomic, weak) IBOutlet UIView *labelContainer;
@property (nonatomic, strong) GCDWebServer *webServer;
@property (nonatomic, strong) VTSimplePlayer *player;

@end

@implementation SimpleDRMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create server
    _webServer = [[GCDWebServer alloc] init];
    
    NSString *dir=[NSHomeDirectory() stringByAppendingPathComponent:@"tmp/www/"];
    [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_output" ofType:@"mp4"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"mp4"];
    NSString *toPath = [dir stringByAppendingPathComponent:@"text"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    }
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:nil];
    
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:dir indexFilename:nil cacheAge:3600 allowRangeRequests:YES];
    [_webServer startWithPort:8989 bonjourName:nil];
    
    _player = [VTSimplePlayer new];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf.player playURL:@"http://localhost:8989/text.mp4" inView:self.labelContainer];
        [weakSelf.player playURL:@"jedi://text.m3u8" inView:self.labelContainer];
    });
    
    return;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self getMP4File];
//}

- (void)getMP4File {
    NSString *url = [NSString stringWithFormat:@"http://localhost:%@/text.mp4", @(8989)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
        NSData *data = [[NSData alloc]initWithContentsOfFile:imgFilePath];
        NSLog(@"%@", data);
    }];
    [_downloadTask resume];
}

- (void)dealloc {
    [_webServer stop];
    _webServer = nil;
}


@end
