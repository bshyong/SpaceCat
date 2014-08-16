//
//  STSpaceDogNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/16/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STSpaceDogNode.h"

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
  
  SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
  [spaceDog runAction:[SKAction repeatActionForever:animation]];
  
  return spaceDog;
}
@end
