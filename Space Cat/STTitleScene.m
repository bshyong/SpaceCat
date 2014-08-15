//
//  STTitleScene.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STTitleScene.h"
#import "STGameplayScene.h"

@implementation STTitleScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    // center background at middle of frame
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    // add background as a child node
    [self addChild:background];
  }
  return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  STGameplayScene *gamePlayScene = [STGameplayScene sceneWithSize:self.frame.size];
  // create transition to gameplay scene
  SKTransition *transition = [SKTransition fadeWithDuration:1.0];
  // present the new scene with the specified transition
  [self.view presentScene:gamePlayScene transition:transition];
  
}

@end
