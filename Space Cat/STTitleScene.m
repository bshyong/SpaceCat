//
//  STTitleScene.m
//  Space Cat
//
//  Created by Benjamin Shyong on 8/15/14.
//  Copyright (c) 2014 ShyongTech. All rights reserved.
//

#import "STTitleScene.h"
#import "STGameplayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface STTitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end


@implementation STTitleScene

-(id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    // center background at middle of frame
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    // add background as a child node
    [self addChild:background];
    
    self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
    
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
  }
  return self;
}

- (void) didMoveToView:(SKView *)view{
  [self.backgroundMusic play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  [self runAction:self.pressStartSFX];
  [self.backgroundMusic stop];
  
  STGameplayScene *gamePlayScene = [STGameplayScene sceneWithSize:self.frame.size];
  // create transition to gameplay scene
  SKTransition *transition = [SKTransition fadeWithDuration:1.0];
  // present the new scene with the specified transition
  [self.view presentScene:gamePlayScene transition:transition];
}

@end
