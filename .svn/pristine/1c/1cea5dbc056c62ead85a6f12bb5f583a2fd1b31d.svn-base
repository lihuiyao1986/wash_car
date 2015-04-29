//
//  NacheImageCache.m
//  NaChe
//
//  Created by yanshengli on 14-12-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ImageCache.h"
#import "UIImageView+WebCache.h"

static NSString *identifier = @"com.cheletong.imagecache.tg";
@implementation ImageCache

- (instancetype)init {
    self = [super init];
    if(self) {
    }
    return self;
}

#pragma 加载图片
+ (void)loadImageWithUrl:(NSString *) url imageView:(UIImageView *)imageView placeholderImage:(NSString*)placeholderImage cacheImage:(BOOL)cache{
    if(url==nil||url.length==0){
        return ;
    }
    if(![url hasPrefix:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@", BASE_HOST, url];
    }
    UIImage *image = [ImageCache getImageForURL:url];
    if (cache && image) {
        imageView .image = image;
        return;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error && cache) {
            [ImageCache setImage:imageView.image forURL:url];
        }
    }];
}

#pragma
+ (void)setImage:(UIImage *)image forURL:(NSString *)URL {
    //创建缓存目录
    NSArray  *paths   = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *rootCachePath = [paths firstObject];
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSString *cachePath  = [rootCachePath stringByAppendingPathComponent:identifier];
    if(![fileManager fileExistsAtPath:identifier]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    //保存图片
    NSData   *imageData = nil;
    NSString *fileExtension = [[URL componentsSeparatedByString:@"."] lastObject];
    if([fileExtension isEqualToString:@"png"]) {
        imageData  = UIImagePNGRepresentation(image);
    } else if([fileExtension isEqualToString:@"jpg"] || [fileExtension isEqualToString:@"jpeg"]) {
        imageData  = UIImageJPEGRepresentation(image, 1.f);
    } else return;
    [imageData writeToFile:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[NSNumber numberWithInteger:URL.hash], fileExtension]] atomically:YES];
}


+ (UIImage *)getImageForURL:(NSString *)URL {
    //创建缓存目录
    NSArray  *paths   = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *rootCachePath = [paths firstObject];
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSString *cachePath  = [rootCachePath stringByAppendingPathComponent:identifier];
    if(![fileManager fileExistsAtPath:identifier]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    //取出缓存的图片
    NSString *fileExtension = [[URL componentsSeparatedByString:@"."] lastObject];
    NSString *path = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", [NSNumber numberWithInteger:URL.hash], fileExtension]];
    if([fileManager fileExistsAtPath:path]) {
        return [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
    }
    return nil;
}

@end
