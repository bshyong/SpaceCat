//
//  STHudNode.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/19/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STHudNode.h"
#import "STUtility.h"

@implementation STHudNode
+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame{
  STHudNode *hud = [self node];
  hud.position = position;
  hud.zPosition = 10;
  
  SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
  catHead.position = CGPointMake(30, -10);
  [hud addChild:catHead];
  
  hud.lives = STMaxLives;
  
  SKSpriteNode *lastLifeBar;
  
  for (int i=0; i < hud.lives; i++) {
    SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
    lifeBar.name =[NSString stringWithFormat:@"Life%d", i+1];
    [hud addChild:lifeBar];
    
    if(lastLifeBar == nil){
      lifeBar.position = CGPointMake(catHead.position.x+30, catHead.position.y);
    } else {
      lifeBar.position = CGPointMake(lastLifeBar.position.x+10, lastLifeBar.position.y);
    }
    lastLifeBar = lifeBar;
  }
  
  SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
  scoreLabel.name = @"Score";
  scoreLabel.text = @"0";
  scoreLabel.fontSize = 24;
  scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
  scoreLabel.position = CGPointMake(frame.size.width-20, -10);
  [hud addChild:scoreLabel];
  
  return hud;
}
@end
