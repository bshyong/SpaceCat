//
//  STSpaceCatNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STSpaceCatNode.h"

@interface STSpaceCatNode()
  @property (nonatomic) SKAction *tapAction;
@end

@implementation STSpaceCatNode

+ (instancetype)spaceCatAtPosition:(CGPoint)position{
  STSpaceCatNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
  spaceCat.position = position;
  spaceCat.anchorPoint = CGPointMake(0.5, 0);
  spaceCat.name = @"SpaceCat";

  return spaceCat;
}

// override getter for _tapAction
- (SKAction *) tapAction{
  if (_tapAction != nil){
    return _tapAction;
  }
  
  NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                        [SKTexture textureWithImageNamed:@"spacecat_1"]];
  
  _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];

  return _tapAction;
}

- (void)performTap{
  [self runAction:self.tapAction];
}


@end
