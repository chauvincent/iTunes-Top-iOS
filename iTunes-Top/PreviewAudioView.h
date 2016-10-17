//
//  PreviewAudioView.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseStoreItem.h"
#import "Song.h"
#import "AudioBook.h"

@interface PreviewAudioView : UIView

- (void)showMenu:(BaseStoreItem *)item;

@end
