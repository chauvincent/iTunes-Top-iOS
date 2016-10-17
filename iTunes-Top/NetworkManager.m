//
//  NetworkManager.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (NetworkManager *)sharedInstance
{
    static NetworkManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NetworkManager alloc] init];
    });
    
    return _sharedInstance;
}

+ (void)downloadImagesWithUrl:(NSString *)url withCompletion:(void (^)(UIImage *image, bool success))block
{

        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (response)
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (image != nil)
                        {
                            block(image, true);
                            //[imgCache setObject:image forKey:url];
                        }
                        else
                        {
                            UIImage *badImage = [UIImage imageNamed:@"badImage"];
                            //[imgCache setObject:badImage forKey:url];
                            block(badImage, false);
                        }
                    });
                });
            }
        }];
        [task resume];
        
    
}

@end
