//
//  ViewController.h
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 27.01.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SingleObjectController : NSViewController

// info fields
@property (weak) IBOutlet NSTextField *backParam1;
@property (weak) IBOutlet NSTextField *backParam2;
@property (weak) IBOutlet NSTextField *objColor;
@property (weak) IBOutlet NSTextField *lightColor;
@property (weak) IBOutlet NSTextField *infoTower;


// object
@property (weak) IBOutlet NSTextField *R_obj;
@property (weak) IBOutlet NSTextField *G_obj;
@property (weak) IBOutlet NSTextField *B_obj;

@property (weak) IBOutlet NSTextField *L_obj;
@property (weak) IBOutlet NSTextField *a_obj;
@property (weak) IBOutlet NSTextField *bb_obj;

// object with light
@property (weak) IBOutlet NSTextField *R_with_light;
@property (weak) IBOutlet NSTextField *G_with_light;
@property (weak) IBOutlet NSTextField *B_with_light;

@property (weak) IBOutlet NSTextField *L_with_light;
@property (weak) IBOutlet NSTextField *a_with_light;
@property (weak) IBOutlet NSTextField *bb_with_light;

// delta
@property (weak) IBOutlet NSTextField *delta76;
@property (weak) IBOutlet NSTextField *delta94;
@property (weak) IBOutlet NSTextField *delta00;


// buttons
- (IBAction)openColor:(NSButton *)sender;
- (IBAction)openLight:(NSButton *)sender;
- (IBAction)resetButton:(NSButton *)sender;

-(void) updateView;


@end

