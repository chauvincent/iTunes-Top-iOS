//
//  NetworkManager.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkManager : NSObject
{
    NetworkManager *sharedInstance;
}

+ (void)downloadImagesWithUrl:(NSString *)url withCompletion:(void (^)(UIImage *image, bool success))block;

@end
