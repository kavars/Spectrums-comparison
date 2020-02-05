//
//  PaletteController.m
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 04.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "PaletteController.h"

#import "ColorClass.h"
#import "CXFPalette.h"

@interface PaletteController ()

@property ColorClass *object, *objectWithLight;

// spectrums arrays
@property NSArray *currentObjectArr, *currentLightArr;

// array with objects and lights
@property NSArray *palette;
@property NSString *palettePath;

@end


// =======================================================

@implementation PaletteController

@synthesize object, objectWithLight;

// spectrums arrays
@synthesize currentObjectArr, currentLightArr;

// array with objects and lights
@synthesize palette;
@synthesize palettePath;

// pop up
@synthesize objectPopUpOutlet, lightPopUpOutlet;

// info fields
@synthesize backParam1, backParam2, infoTower;
@synthesize objColor, lightColor;

// object
@synthesize R_obj, G_obj, B_obj;
@synthesize L_obj, a_obj, bb_obj;

// object with light
@synthesize R_with_light, G_with_light, B_with_light;
@synthesize L_with_light, a_with_light, bb_with_light;

// delta
@synthesize delta76, delta94, delta00;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    object = [[ColorClass alloc] init];
    objectWithLight = [[ColorClass alloc] init];
    
    palette = [NSArray array];
    
    [self updateView];
}


- (IBAction)openPalette:(NSButton *)sender {
    NSOpenPanel *panel = [[NSOpenPanel alloc] init];
    
    panel.title = @"Open palette file";
    
    panel.showsResizeIndicator    = true;
    panel.showsHiddenFiles        = false;
    panel.canChooseDirectories    = true;
    panel.canCreateDirectories    = true;
    panel.allowsMultipleSelection = false;
    panel.allowedFileTypes        = @[@"cxf"];
    
    if ([panel runModal] == NSModalResponseOK) {
        // Pathname of the file
        NSURL *result = panel.URL;
        
        if (result != nil) {
            palettePath = result.path;
            
            if ([[palettePath pathExtension]  isEqual: @"cxf"]) {
                CXFPalette *CXFParser = [[CXFPalette alloc] init];
                
                palette = [CXFParser openCXF: palettePath];
                
                // build pop up buttons with palette data
                [self buildPopUpButtons];
            } else {
                NSAlert *alert = [[NSAlert alloc] init];
                [alert setMessageText:@"Wrong file type."];
                [alert setInformativeText:@"Choose cxf file."];
                [alert addButtonWithTitle:@"Ok"];
                [alert runModal];
                palettePath = nil;
            }
        }
    } else {
        // User clicked on "Cancel"
        return;
    }
}

-(void) buildPopUpButtons
{
    [objectPopUpOutlet removeAllItems];
    [lightPopUpOutlet  removeAllItems];
    
    NSMutableArray *objLables = [NSMutableArray array];
    NSMutableArray *lightLables = [NSMutableArray array];

    if (palette[0] != nil) {
        for (NSString *key in palette[0]) {
            [objLables addObject: key];
        }
    }
    
    if (palette[1] != nil) {
        for (NSString *key in palette[1]) {
            [lightLables addObject: key];
        }
    }

    
    [objLables sortUsingSelector: @selector(compare:)];
    [lightLables sortUsingSelector: @selector(compare:)];
    
    [objectPopUpOutlet addItemsWithTitles: objLables];
    [lightPopUpOutlet  addItemsWithTitles: lightLables];

    // А я имею ввиду: отображать только 15 элементов, остальные скрывать
    
    objectPopUpOutlet.target = self;
    objectPopUpOutlet.action = @selector(objectPopUp:);
    lightPopUpOutlet.target = self;
    lightPopUpOutlet.action = @selector(lightPopUp:);
}

- (IBAction)objectPopUp:(NSPopUpButton *)sender {
    
    if (palette[0] != nil) {
        
        currentObjectArr = [NSArray array];
        
        currentObjectArr = [palette[0] objectForKey: sender.title];
        
        object = [[ColorClass alloc] initWithObjectSpectrumsArray: currentObjectArr];
        
        if (currentLightArr != nil) {
            objectWithLight = [[ColorClass alloc] initWithObjectSpectrumsArray: currentObjectArr andLightSpectrumsArray: currentLightArr];
        }
        
        [self updateView];
    }

}

- (IBAction)lightPopUp:(NSPopUpButton *)sender {
        if (palette[1] != nil) {
            
            currentLightArr = [NSArray array];
            
            if (currentObjectArr == nil) {
                return;
            }
            
            currentLightArr = [palette[1] objectForKey: sender.title];
            
            objectWithLight = [[ColorClass alloc] initWithObjectSpectrumsArray: currentObjectArr andLightSpectrumsArray: currentLightArr];
            
            [self updateView];

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
    
    
    // Set colors
    objColor.backgroundColor = [NSColor colorWithRed: ([[object R] intValue] / 255.0) green: ([[object G] intValue] / 255.0) blue: ([[object B] intValue] / 255.0) alpha: 1.0];
        
    lightColor.backgroundColor = [NSColor colorWithRed: ([[objectWithLight R] intValue] / 255.0) green: ([[objectWithLight G] intValue] / 255.0) blue: ([[objectWithLight B] intValue] / 255.0) alpha: 1.0];

}

@end
