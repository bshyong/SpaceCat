//
//  STSpaceDogNode.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/16/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, STSpaceDogType) {
  STSpaceDogTypeA = 0,
  STSpaceDogTypeB = 1
};


@interface STSpaceDogNode : SKSpriteNode
+ (instancetype) spaceDogOfType:(STSpaceDogType)type;
@end
