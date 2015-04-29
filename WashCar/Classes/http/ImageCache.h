//
//  NacheImageCache.h
//  NaChe
//
//  Created by yanshengli on 14-12-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCache : NSObject{
    NSFileManager *_fileManager;
    NSString *_cachePath;
}
#pragma 加载图片
+ (void)loadImageWithUrl:(NSString *) url imageView:(UIImageView *)imageView placeholderImage:(NSString*)placeholderImage cacheImage:(BOOL)cache;
@end
