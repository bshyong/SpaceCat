//
//  STGroundNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/17/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STGroundNode.h"
#import "STUtility.h"

@implementation STGroundNode
+ (instancetype) groundWithSize:(CGSize)size{
  STGroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
  ground.name = @"Ground";
  ground.position = CGPointMake(size.width/2, size.height/2);
  [ground setupPhysicsBody];

  return ground;
}

-(void)setupPhysicsBody{
  self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
  self.physicsBody.affectedByGravity = NO;
  self.physicsBody.dynamic = NO;
  self.physicsBody.categoryBitMask = STCollisionCategoryGround;
  self.physicsBody.collisionBitMask = STCollisionCategoryDebris;
  self.physicsBody.contactTestBitMask = STCollisionCategoryEnemy;
}

@end
