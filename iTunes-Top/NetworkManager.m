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


+ (void)getDataFromEndpoint:(NSString *)endpointString withCompletion:(void (^)(bool success, NSArray *entry))block
{
    NSURL *url = [NSURL URLWithString:endpointString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSError *error;
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSDictionary *feedDict = responseJSON[@"feed"];
            NSArray *entry = feedDict[@"entry"];
            block(true, entry);
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
            block(false, nil);
        }
        
    }];
    
    [dataTask resume];
    
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
