//
//  STSpaceCatNode.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STSpaceCatNode : SKSpriteNode
+ (instancetype) spaceCatAtPosition:(CGPoint)position;
- (void) performTap;
@end
