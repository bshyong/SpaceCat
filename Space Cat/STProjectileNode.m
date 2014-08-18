//
//  STProjectileNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STProjectileNode.h"
#import "STUtility.h"

@implementation STProjectileNode
+(instancetype)projectileAtPosition:(CGPoint) position{
  STProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
  projectile.position = position;
  projectile.name = @"Projectile";
  [projectile setupAnimation];
  [projectile setupPhysicsBody];
  
  return projectile;
}

-(void)setupAnimation{
  NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                        [SKTexture textureWithImageNamed:@"projectile_2"],
                        [SKTexture textureWithImageNamed:@"projectile_3"]];
  SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
  SKAction *repeatAction = [SKAction repeatActionForever:animation];
  [self runAction:repeatAction];
}

-(void)setupPhysicsBody {
  self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
  self.physicsBody.affectedByGravity = NO;
  self.physicsBody.categoryBitMask = STCollisionCategoryProjectile;
  self.physicsBody.collisionBitMask = 0;
  self.physicsBody.contactTestBitMask = STCollisionCategoryEnemy;
}

-(void)moveTowardsPosition:(CGPoint)position{
  float slope = (position.y - self.position.y) / (position.x - self.position.x);
  float offscreenX;
  
  if(position.x <= self.position.x){
    offscreenX = -10;
  } else {
    offscreenX = self.parent.frame.size.width + 10;
  }
  
  float offscreenY = slope * offscreenX - slope * self.position.x + self.position.y;
  
  CGPoint pointOffScreen = CGPointMake(offscreenX, offscreenY);
  
  float distanceA = pointOffScreen.y - self.position.y;
  float distanceB = pointOffScreen.x - self.position.x;
  float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
  
  float time = distanceC / STProjectileSpeed;
  
  SKAction *moveProjectile = [SKAction moveTo:pointOffScreen duration:time];
  [self runAction:moveProjectile];
}

@end
