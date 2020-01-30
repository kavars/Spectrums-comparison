//
//  ViewController.m
//  Lab 2
//
//  Created by Kirill Varshamov on 27.01.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize colorPath, lightPath;
@synthesize object, objectWithLight;

@synthesize backParam1, backParam2, infoTower;

@synthesize objColor, lightColor;

@synthesize R_obj, G_obj, B_obj;
@synthesize L_obj, a_obj, bb_obj;

@synthesize R_with_light, G_with_light, B_with_light;
@synthesize L_with_light, a_with_light, bb_with_light;

@synthesize delta76, delta94, delta00;


- (void)viewDidLoad {
    [super viewDidLoad];
 
    object = [[ColorClass alloc] init];
    objectWithLight = [[ColorClass alloc] init];
    
    [self updateView];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)openColor:(NSButton *)sender {
    NSOpenPanel *panel = [[NSOpenPanel alloc] init];
    
    panel.title = @"Open color txt file";
    
    panel.showsResizeIndicator    = true;
    panel.showsHiddenFiles        = false;
    panel.canChooseDirectories    = true;
    panel.canCreateDirectories    = true;
    panel.allowsMultipleSelection = false;
    panel.allowedFileTypes        = @[@"txt"];
    
    if ([panel runModal] == NSModalResponseOK) {
        // Pathname of the file
        NSURL *result = panel.URL;
        
        if (result != nil) {
            colorPath = result.path;
            [self openColorSpector];
            
            // recompute new object with old light
            if (lightPath != nil) {
                [self openLightSpector];
            }
            [self updateView];
        }
    } else {
        // User clicked on "Cancel"
        return;
    }
}

- (IBAction)openLight:(NSButton *)sender {
    NSOpenPanel *panel = [[NSOpenPanel alloc] init];
        
    panel.title = @"Open light txt file";
    
    panel.showsResizeIndicator    = true;
    panel.showsHiddenFiles        = false;
    panel.canChooseDirectories    = true;
    panel.canCreateDirectories    = true;
    panel.allowsMultipleSelection = false;
    panel.allowedFileTypes        = @[@"txt"];
        
    if ([panel runModal] == NSModalResponseOK) {
        // Pathname of the file
        NSURL *result = panel.URL;
            
        if (result != nil) {
            lightPath = result.path;

            [self openLightSpector];
            [self updateView];
        }
    } else {
        // User clicked on "Cancel"
        return;
    }
}

- (IBAction)resetButton:(NSButton *)sender {
    object = [[ColorClass alloc] init];
    objectWithLight = [[ColorClass alloc] init];
    
    [self updateView];
}

-(void) openColorSpector
{
    object = [[ColorClass alloc] initWithSpector: colorPath];
}

-(void) openLightSpector
{
    // open light only after object
    if (colorPath != nil) {
        objectWithLight = [[ColorClass alloc] initWithObject: colorPath WithLight: lightPath];
    }
}

-(void) updateView
{
    backParam1.bezelStyle = NSTextFieldRoundedBezel;
    backParam2.bezelStyle = NSTextFieldRoundedBezel;
    infoTower.bezelStyle  = NSTextFieldRoundedBezel;
    
    NSNumberFormatter *twoDigitForm = [[NSNumberFormatter alloc] init];
    
    twoDigitForm.maximumFractionDigits = 2;
        
    R_obj.stringValue = [twoDigitForm stringFromNumber: [object R]];
    G_obj.stringValue = [twoDigitForm stringFromNumber: [object G]];
    B_obj.stringValue = [twoDigitForm stringFromNumber: [object B]];

    L_obj.stringValue = [twoDigitForm stringFromNumber: [object L]];
    a_obj.stringValue = [twoDigitForm stringFromNumber: [object a]];
    bb_obj.stringValue = [twoDigitForm stringFromNumber: [object bb]];
        
    R_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight R]];
    G_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight G]];
    B_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight B]];
        
    L_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight L]];
    a_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight a]];
    bb_with_light.stringValue = [twoDigitForm stringFromNumber: [objectWithLight bb]];
        
    delta76.stringValue = [twoDigitForm stringFromNumber: [objectWithLight deltaE76: object]];
    delta94.stringValue = [twoDigitForm stringFromNumber: [objectWithLight deltaE94: object]];
    delta00.stringValue = [twoDigitForm stringFromNumber: [objectWithLight deltaE00: object]];
    
    
    // Set color
    objColor.backgroundColor = [NSColor colorWithRed: ([[object R] intValue] / 255.0) green: ([[object G] intValue] / 255.0) blue: ([[object B] intValue] / 255.0) alpha: 1.0];
        
    lightColor.backgroundColor = [NSColor colorWithRed: ([[objectWithLight R] intValue] / 255.0) green: ([[objectWithLight G] intValue] / 255.0) blue: ([[objectWithLight B] intValue] / 255.0) alpha: 1.0];

}

@end
