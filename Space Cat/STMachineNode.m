//
//  STMachineNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STMachineNode.h"

@implementation STMachineNode

+ (instancetype)machineAtPosition:(CGPoint)position{
  STMachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
  machine.position = position;
  machine.anchorPoint = CGPointMake(0.5, 0);
  
  NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                        [SKTexture textureWithImageNamed:@"machine_2"]];
  SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
  SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
  [machine runAction:machineRepeat];
  return machine;
}

@end
