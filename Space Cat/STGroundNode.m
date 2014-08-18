//
//  STGroundNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/17/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STGroundNode.h"

@implementation STGroundNode
+ (instancetype) groundWithSize:(CGSize)size{
  STGroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
  ground.name = @"Ground";
  ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
  ground.position = CGPointMake(size.width/2, size.height/2);
  ground.physicsBody.affectedByGravity = NO;

  return ground;
}
@end
