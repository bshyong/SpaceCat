//
//  STGameplayScene.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STGameplayScene.h"
#import "STMachineNode.h"
#import "STSpaceCatNode.h"
#import "STProjectileNode.h"
#import "STSpaceDogNode.h"
#import "STGroundNode.h"

@implementation STGameplayScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    // center background at middle of frame
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    // add background as a child node
    [self addChild:background];
    
    STMachineNode *machine = [STMachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
    [self addChild:machine];
    
    STSpaceCatNode *spaceCat = [STSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
    [self addChild:spaceCat];
    
    [self addSpaceDog];
    
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    
    STGroundNode *ground = [STGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
    [self addChild:ground];
    
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
  for (UITouch *touch in touches) {
    CGPoint position = [touch locationInNode:self];
    [self shootProjectileTowardsPosition:position];
  }

}

-(void)shootProjectileTowardsPosition:(CGPoint)position{
  STSpaceCatNode *spaceCat = (STSpaceCatNode *)[self childNodeWithName:@"SpaceCat"];
  [spaceCat performTap];
  
  STMachineNode *machine = (STMachineNode *)[self childNodeWithName:@"Machine"];
  
  STProjectileNode *projectile = [STProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y+machine.frame.size.height-15)];
  [self addChild:projectile];
  [projectile moveTowardsPosition:position];
}

-(void)addSpaceDog{
  STSpaceDogNode *spaceDogA = [STSpaceDogNode spaceDogOfType:STSpaceDogTypeA];
  spaceDogA.position = CGPointMake(300, 300);
  [self addChild:spaceDogA];
  
  STSpaceDogNode *spaceDogB = [STSpaceDogNode spaceDogOfType:STSpaceDogTypeB];
  spaceDogB.position = CGPointMake(200, 200);
  [self addChild:spaceDogB];
}


@end
