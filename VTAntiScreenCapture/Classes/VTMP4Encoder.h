//
//  VTMP4Encoder.h
//  AFNetworking
//
//  Created by Vincent on 2019/1/1.
//

#import <Foundation/Foundation.h>

@interface VTMP4Encoder : NSObject

/// 根据视图内容生成mp4文件
+ (void)encodeViewToMP4:(UIView *)view completion:(void (^)(NSData *))handler;

@end
