//
//  STUtility.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STUtility.h"

@implementation STUtility
+ (NSInteger)randWithMin:(NSInteger)min max:(NSInteger)max{
  return arc4random()%(max - min) + min;
}
@end
