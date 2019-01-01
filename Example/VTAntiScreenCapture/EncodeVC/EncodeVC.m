//
//  EncodeVC.m
//  VTAntiScreenCapture_Example
//
//  Created by Vincent on 2019/1/1.
//  Copyright © 2019 mightyme@qq.com. All rights reserved.
//

#import "EncodeVC.h"
#import <VTAntiScreenCapture/VTMP4Encoder.h>

@implementation EncodeVC

- (IBAction)onCreateVideo:(id)sender {
    [VTMP4Encoder encodeViewToMP4:self.label completion:^(NSData *data) {
        NSLog(@"data: %@", data);
    }];
}

@end
