//
//  STProjectileNode.h
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STProjectileNode : SKSpriteNode
  +(instancetype)projectileAtPosition:(CGPoint) position;
  -(void)moveTowardsPosition:(CGPoint)position;
@end
