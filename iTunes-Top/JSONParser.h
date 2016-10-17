//
//  JSONParser.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

- (void)parseAudioBookJSONWithEntry:(NSArray *)entries withCompletion:(void (^)(NSMutableArray *allAudioBooks))block;
- (void)parseSongJSONWithEntry:(NSArray *)entries withCompletion:(void (^)(NSMutableArray *allSongs))block;
- (void)parseCollectionJSONWithEntry:(NSArray *)entries withCompletion:(void (^)(NSMutableArray *collection))block;

@end
