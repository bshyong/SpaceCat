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
#import "STUtility.h"
#import <AVFoundation/AVFoundation.h>

@interface STGameplayScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation STGameplayScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    
    self.lastUpdateTimeInterval = 0;
    self.timeSinceEnemyAdded = 0;
    self.addEnemyTimeInterval = 1.5;
    self.minSpeed = STSpaceDogMinSpeed;
    self.totalGameTime = 0;
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    // center background at middle of frame
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    // add background as a child node
    [self addChild:background];
    
    STMachineNode *machine = [STMachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
    [self addChild:machine];
    
    STSpaceCatNode *spaceCat = [STSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
    [self addChild:spaceCat];
    
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    
    STGroundNode *ground = [STGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
    [self addChild:ground];
    
    [self setupSounds];
  }
  return self;
}

- (void) setupSounds {
  self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
  self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
  self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
  
  NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
  self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
  self.backgroundMusic.numberOfLoops = -1;
  [self.backgroundMusic prepareToPlay];
  
}

- (void) didMoveToView:(SKView *)view{
  [self.backgroundMusic play];
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
  
  [self runAction:self.laserSFX];
}

-(void)addSpaceDog{
  NSUInteger randomSpaceDog = [STUtility randWithMin:0 max:2];
  STSpaceDogNode *spaceDog = [STSpaceDogNode spaceDogOfType:randomSpaceDog];
  float dy = [STUtility randWithMin:STSpaceDogMinSpeed max:STSpaceDogMaxSpeed];
  spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
  
  float y = self.frame.size.height + spaceDog.size.height;
  float x = [STUtility randWithMin:10 + spaceDog.size.width max:self.frame.size.width-10-spaceDog.size.width];
  spaceDog.position = CGPointMake(x, y);
  [self addChild:spaceDog];
}

- (void) didBeginContact:(SKPhysicsContact *)contact{
  SKPhysicsBody *first, *second;
  if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
    first = contact.bodyA;
    second = contact.bodyB;
  } else {
    first = contact.bodyB;
    second = contact.bodyA;
  }
  STSpaceDogNode *spaceDog = (STSpaceDogNode *)first.node;

  // create debris at the contact point
  [self createDebrisAtPosition:contact.contactPoint];
  
  if (first.categoryBitMask == STCollisionCategoryEnemy && second.categoryBitMask == STCollisionCategoryProjectile){
    STProjectileNode *projectile = (STProjectileNode *)second.node;
    [self runAction:self.explodeSFX];
    [spaceDog removeFromParent];
    [projectile removeFromParent];
  } else if (first.categoryBitMask == STCollisionCategoryEnemy && second.categoryBitMask == STCollisionCategoryGround){
    [self runAction:self.damageSFX];
    [spaceDog removeFromParent];
  }
}

- (void)createDebrisAtPosition:(CGPoint)position{
  NSInteger numberOfPieces = [STUtility randWithMin:5 max:20];

  for(int i = 0; i < numberOfPieces; i++){
    NSInteger randomPiece = [STUtility randWithMin:1 max:4];
    NSString *imageName = [NSString stringWithFormat:@"debri_%d", randomPiece];
    SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    debris.position = position;
    [self addChild:debris];
    
    debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
    debris.physicsBody.categoryBitMask = STCollisionCategoryDebris;
    debris.physicsBody.contactTestBitMask = 0;
    debris.physicsBody.collisionBitMask = STCollisionCategoryGround | STCollisionCategoryDebris;
    debris.name = @"Debris";
    debris.physicsBody.velocity = CGVectorMake([STUtility randWithMin:-150 max:150], [STUtility randWithMin:150 max:350]);
    [debris runAction:[SKAction waitForDuration:2.0] completion:^{
      [debris removeFromParent];
    }];
    
  }
  
  NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
  SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
  explosion.position = position;
  [self addChild:explosion];
  
  [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
    [explosion removeFromParent];
  }];
}

- (void)update:(NSTimeInterval)currentTime{
  if (self.lastUpdateTimeInterval){
    self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
    self.totalGameTime =+ currentTime - self.lastUpdateTimeInterval;
  }
  if (self.timeSinceEnemyAdded > 1.5){
    [self addSpaceDog];
    self.timeSinceEnemyAdded = 0;
  }
  
  self.lastUpdateTimeInterval = currentTime;
  
  if (self.totalGameTime > 480){
    self.addEnemyTimeInterval = 0.50;
    self.minSpeed = -160;
  } else if (self.totalGameTime > 240){
    self.addEnemyTimeInterval = 0.65;
    self.minSpeed = -150;
  } else if (self.totalGameTime > 120){
    self.addEnemyTimeInterval = 0.75;
    self.minSpeed = -125;
  } else if (self.totalGameTime > 30){
    self.addEnemyTimeInterval = 1.00;
    self.minSpeed = -100;
  }

}


@end
