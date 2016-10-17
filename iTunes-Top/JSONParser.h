//
//  JSONParser.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject


- (void)parseCollectionJSONWithEntry:(NSArray *)entries withCompletion:(void (^)(NSMutableArray *collection))block;

@end
