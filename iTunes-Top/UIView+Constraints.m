//
//  UIView+Constraints.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)


- (void)addVisualConstraintWithFormat:(NSString *)format andView:(NSArray *)views
{
    NSMutableDictionary *viewsDict = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < views.count; i++)
    {
        NSString *key = [NSString stringWithFormat:@"v%d", i];
        UIView *view = views[i];
        view.translatesAutoresizingMaskIntoConstraints = false;
        viewsDict[key] = view;
        
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDict]];
}

@end
