//
//  NSString+Price.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "NSString+Price.h"

@implementation NSString (Price)

+ (NSString *)priceFromString:(NSString *)string
{
    NSNumberFormatter *doubleValueWithMaxTwoDecimalPlaces = [[NSNumberFormatter alloc] init];
    [doubleValueWithMaxTwoDecimalPlaces setNumberStyle:NSNumberFormatterDecimalStyle];
    [doubleValueWithMaxTwoDecimalPlaces setMaximumFractionDigits:2];
    NSNumber *number = @([string doubleValue]);
    return [NSString stringWithFormat:@"$%@", [doubleValueWithMaxTwoDecimalPlaces stringFromNumber:number]];
}

@end
