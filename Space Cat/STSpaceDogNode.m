//
//  STSpaceDogNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/16/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STSpaceDogNode.h"
#import "STUtility.h"

@implementation STSpaceDogNode
+ (instancetype) spaceDogOfType:(STSpaceDogType)type{
  STSpaceDogNode *spaceDog;
  NSArray *textures;
  
  if(type== STSpaceDogTypeA){
    spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
    textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                 [SKTexture textureWithImageNamed:@"spacedog_A_2"],
                 [SKTexture textureWithImageNamed:@"spacedog_A_3"]];
  } else {
    spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
    textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                 [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                 [SKTexture textureWithImageNamed:@"spacedog_B_3"],
                 [SKTexture textureWithImageNamed:@"spacedog_B_4"]];
  }
  
  // modulate the scale of the dogs
  float scale = [STUtility randWithMin:85 max:100] / 100.0f;
  spaceDog.xScale = scale;
  spaceDog.yScale = scale;
  
  SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
  [spaceDog runAction:[SKAction repeatActionForever:animation]];
  
  [spaceDog setupPhysicsBody];
  
  return spaceDog;
}

-(void)setupPhysicsBody{
  self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
  self.physicsBody.affectedByGravity = NO;
  self.physicsBody.velocity = CGVectorMake(0, -15);
  self.physicsBody.categoryBitMask = STCollisionCategoryEnemy;
  self.physicsBody.collisionBitMask = 0;
  self.physicsBody.contactTestBitMask = STCollisionCategoryProjectile | STCollisionCategoryGround;
}


@end
