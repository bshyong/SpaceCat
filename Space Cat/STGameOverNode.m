//
//  STGameOverNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STGameOverNode.h"

@implementation STGameOverNode
+ (instancetype) gameOverAtPosition:(CGPoint)position{
  STGameOverNode *gameOver = [self node];
  
  SKLabelNode *gameOverlabel = [SKLabelNode labelNodeWithFontNamed:@"Future-CondensedExtraBold"];
  gameOverlabel.name = @"GameOver";
  gameOverlabel.text = @"Game Over";
  gameOverlabel.fontSize = 48;
  gameOverlabel.position = position;
  [gameOver addChild:gameOverlabel];
  
  return gameOver;
}
- (void)performAnimation{
  SKLabelNode *label = (SKLabelNode *)[self childNodeWithName:@"GameOver"];
  label.xScale = 0;
  label.yScale = 0;
  SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
  SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
  SKAction *run = [SKAction runBlock:^{
    SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    touchToRestart.text = @"Touch To Restart";
    touchToRestart.fontSize = 24;
    touchToRestart.position = CGPointMake(label.position.x, label.position.y-40);
    [self addChild:touchToRestart];
  }];
  
  SKAction *scaleSequence = [SKAction sequence:@[scaleUp, scaleDown, run]];
  [label runAction:scaleSequence];
}

@end
