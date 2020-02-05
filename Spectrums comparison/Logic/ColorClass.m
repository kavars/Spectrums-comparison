//
//  ColorClass.m
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 27.01.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "ColorClass.h"
#import "readFile.h"

#import "CieCmfXYZSingleton.h"

@implementation ColorClass

@synthesize spector, CieCmfXYZ;
@synthesize R, G, B;
@synthesize X, Y, Z;
@synthesize L, a, bb;


// empty object/light
-(instancetype) init
{
    self = [super init];
    
    if (self) {
        spector = [NSArray array];
        CieCmfXYZ = [NSArray array];
        
        R = [NSNumber numberWithInt: 0];
        G = [NSNumber numberWithInt: 0];
        B = [NSNumber numberWithInt: 0];
        
        X = [NSNumber numberWithDouble: 0.0];
        Y = [NSNumber numberWithDouble: 0.0];
        Z = [NSNumber numberWithDouble: 0.0];

        L = [NSNumber numberWithDouble: 0.0];
        a = [NSNumber numberWithDouble: 0.0];
        bb = [NSNumber numberWithDouble: 0.0];
    }
    return self;
}

// ------------------------------------------------------------------------------------------
// Single part

// single object
-(instancetype) initWithSpector: (NSString *) spectorFile
{
    self = [super init];
    
    if (self) {
        spector = readFileToArray([spectorFile UTF8String]);
        
        if ([spector count] != 36) {
            spector = [NSArray array];
            CieCmfXYZ = [NSArray array];
            R = [NSNumber numberWithInt: 0];
            G = [NSNumber numberWithInt: 0];
            B = [NSNumber numberWithInt: 0];
            
            X = [NSNumber numberWithDouble: 0.0];
            Y = [NSNumber numberWithDouble: 0.0];
            Z = [NSNumber numberWithDouble: 0.0];

            L = [NSNumber numberWithDouble: 0.0];
            a = [NSNumber numberWithDouble: 0.0];
            bb = [NSNumber numberWithDouble: 0.0];
        } else {
            // constants to translate spectrum to XYZ
            CieCmfXYZ = [CieCmfXYZSingleton singleton].CieCmfXYZArray;
            [self spectorToXYZ];
            
            [self XYZToRGB];
            [self XYZToLab];
        }
    }
    
    return self;
}

// single object with light
-(instancetype) initWithObject: (NSString *) spectorFile WithLight: (NSString *) lightFile
{
    self = [super init];
    
    if (self) {
        NSArray *object = readFileToArray([spectorFile UTF8String]);
        
        NSArray *light = readFileToArray([lightFile UTF8String]);
        
        if ([light count] != 36 || [object count] != 36) {
            spector = [NSArray array];
            CieCmfXYZ = [NSArray array];
            R = [NSNumber numberWithInt: 0];
            G = [NSNumber numberWithInt: 0];
            B = [NSNumber numberWithInt: 0];
            
            X = [NSNumber numberWithDouble: 0.0];
            Y = [NSNumber numberWithDouble: 0.0];
            Z = [NSNumber numberWithDouble: 0.0];
            
            L = [NSNumber numberWithDouble: 0.0];
            a = [NSNumber numberWithDouble: 0.0];
            bb = [NSNumber numberWithDouble: 0.0];
        } else {
            NSMutableArray *tmpArr = [NSMutableArray array];
            
            for(int i = 0; i != [object count]; ++i)
            {
                NSNumber *tmpNum = [NSNumber numberWithDouble: [object[i] doubleValue] * [light[i] doubleValue]];
                
                [tmpArr addObject: tmpNum];
            }
            
            // constants to translate spectrum to XYZ
            CieCmfXYZ = [CieCmfXYZSingleton singleton].CieCmfXYZArray;
            
            spector = [NSArray arrayWithArray: tmpArr];
            
            
            [self spectorToXYZ];
            [self XYZToRGB];
            [self XYZToLab];
        }
        
    }
    
    return self;
}

// ------------------------------------------------------------------------------------------



// ------------------------------------------------------------------------------------------
// Palette part

// object from cxf palette
-(instancetype) initWithObjectSpectrumsArray: (NSArray *) objectSpectrumsArray
{
    self = [super init];
    
    if (self) {
        spector = objectSpectrumsArray;
        
        if ([spector count] != 36) {
            spector = [NSArray array];
            CieCmfXYZ = [NSArray array];
            R = [NSNumber numberWithInt: 0];
            G = [NSNumber numberWithInt: 0];
            B = [NSNumber numberWithInt: 0];
            
            X = [NSNumber numberWithDouble: 0.0];
            Y = [NSNumber numberWithDouble: 0.0];
            Z = [NSNumber numberWithDouble: 0.0];

            L = [NSNumber numberWithDouble: 0.0];
            a = [NSNumber numberWithDouble: 0.0];
            bb = [NSNumber numberWithDouble: 0.0];
        } else {
            // constants to translate spectrum to XYZ
            CieCmfXYZ = [CieCmfXYZSingleton singleton].CieCmfXYZArray;
            
            [self spectorToXYZ];
            
            [self XYZToRGB];
            [self XYZToLab];
        }
    }
    
    return self;
}

// object with light from cxf palette
-(instancetype) initWithObjectSpectrumsArray: (NSArray *) objectSpectrumsArray andLightSpectrumsArray: (NSArray *) lightSpectrumsArray
{
    self = [super init];
    
    if (self) {
        
        NSMutableArray *tmpSpectrums = [NSMutableArray array];
        
        for(int i = 0; i != [lightSpectrumsArray count]; ++i)
        {
            [tmpSpectrums addObject: [[NSNumber alloc] initWithDouble:[objectSpectrumsArray[i] doubleValue] * [lightSpectrumsArray[i] doubleValue]]];
        }
        
        spector = [NSArray arrayWithArray: tmpSpectrums];
        
        if ([spector count] != 36) {
            spector = [NSArray array];
            CieCmfXYZ = [NSArray array];
            R = [NSNumber numberWithInt: 0];
            G = [NSNumber numberWithInt: 0];
            B = [NSNumber numberWithInt: 0];
            
            X = [NSNumber numberWithDouble: 0.0];
            Y = [NSNumber numberWithDouble: 0.0];
            Z = [NSNumber numberWithDouble: 0.0];

            L = [NSNumber numberWithDouble: 0.0];
            a = [NSNumber numberWithDouble: 0.0];
            bb = [NSNumber numberWithDouble: 0.0];
        } else {
            // constants to translate spectrum to XYZ
            CieCmfXYZ = [CieCmfXYZSingleton singleton].CieCmfXYZArray;
            
            [self spectorToXYZ];
            
            [self XYZToRGB];
            [self XYZToLab];
        }
    }
    
    return self;
}

// ------------------------------------------------------------------------------------------



-(void) spectorToXYZ
{
    double sumX = 0;
    double sumY = 0;
    double sumZ = 0;

    int spec = 380;
    
    for (int i = 0, y = 0; i != [spector count]; ++i) {
        sumX += spec * [spector[i] doubleValue] * [CieCmfXYZ[y] doubleValue] * spec;
        sumY += spec * [spector[i] doubleValue] * [CieCmfXYZ[y + 1] doubleValue] * spec;
        sumZ += spec * [spector[i] doubleValue] * [CieCmfXYZ[y + 2] doubleValue] * spec;
        
        spec += 10;
        y += 3;
    }

    double k = 100 / (sumY * 10);

    X = [NSNumber numberWithDouble: k * sumX * 10 / 100];
    Y = [NSNumber numberWithDouble: k * sumY * 10 / 100];
    Z = [NSNumber numberWithDouble: k * sumZ * 10 / 100];
}

-(void) XYZToRGB
{
    double var_R = [X doubleValue] * 3.2404542 + [Y doubleValue] * -1.5371385 + [Z doubleValue] * -0.4985314;
    double var_G = [X doubleValue] * -0.9692660 + [Y doubleValue] * 1.8760108 + [Z doubleValue] * 0.0415560;
    double var_B = [X doubleValue] * 0.0556434 + [Y doubleValue] * -0.2040259 + [Z doubleValue] * 1.0572252;

    int r = ((var_R > 0.0031308) ? (1.055*pow(var_R, 1 / 2.4) - 0.055) : (12.92*var_R)) * 255.0;
    int g = ((var_G > 0.0031308) ? (1.055*pow(var_G, 1 / 2.4) - 0.055) : (12.92*var_G)) * 255.0;
    int b = ((var_B > 0.0031308) ? (1.055*pow(var_B, 1 / 2.4) - 0.055) : (12.92*var_B)) * 255.0;
    
    if (r < 0) {
        r = 0;
    }
    if (g < 0) {
        g = 0;
    }
    if (b < 0) {
        b = 0;
    }
    
    if (r > 255) {
        r = 255;
    }
    if (g > 255) {
        g = 255;
    }
    if (b > 255) {
        b = 255;
    }
    
    R = [NSNumber numberWithInt: r];
    G = [NSNumber numberWithInt: g];
    B = [NSNumber numberWithInt: b];
}

-(void) XYZToLab
{
    // CIE 1931 | D65
    
    double var_X = [X doubleValue] * 100 / 95.047;
    double var_Y = [Y doubleValue] * 100 / 100.000;
    double var_Z = [Z doubleValue] * 100 / 108.883;

    var_X = (var_X > 0.008856) ? cbrt(var_X) : (7.787 * var_X + 16.0 / 116.0);
    var_Y = (var_Y > 0.008856) ? cbrt(var_Y) : (7.787 * var_Y + 16.0 / 116.0);
    var_Z = (var_Z > 0.008856) ? cbrt(var_Z) : (7.787 * var_Z + 16.0 / 116.0);
    
    L = [NSNumber numberWithDouble: ( 116 * var_Y ) - 16];
    a = [NSNumber numberWithDouble: 500 * ( var_X - var_Y )];
    bb = [NSNumber numberWithDouble: 200 * ( var_Y - var_Z )];
}

-(NSNumber *) deltaE76: (ColorClass *) colorClass
{
    NSNumber *delta;
    
    double tmp = pow([colorClass.L doubleValue] - [L doubleValue], 2) + pow([colorClass.a doubleValue] - [a doubleValue], 2) + pow([colorClass.bb doubleValue] - [bb doubleValue], 2);
    
    delta = [NSNumber numberWithDouble: sqrt(tmp)];
    
    return delta;
}

-(NSNumber *) deltaE94: (ColorClass *) colorClass
{
    NSNumber *delta;
    
    double H_1 = atan2([bb doubleValue], [a doubleValue]);
    double H_2 = atan2([colorClass.bb doubleValue], [colorClass.a doubleValue]);

    if ( H_1 > 0 ) {
        H_1 = H_1 / M_PI * 180;
    } else {
        H_1 = 360 - fabs(H_1) / M_PI * 180;
    }
    
    if ( H_2 > 0 ) {
        H_2 = H_2 / M_PI * 180;
    } else {
        H_2 = 360 - fabs(H_2) / M_PI * 180;
    }

    double C_1 = sqrt([a doubleValue] * [a doubleValue] + [bb doubleValue] * [bb doubleValue]);
    double C_2 = sqrt([colorClass.a doubleValue] * [colorClass.a doubleValue] + [colorClass.bb doubleValue] * [colorClass.bb doubleValue]);

    double LDelta = ([colorClass.L doubleValue] - [L doubleValue]) / 1;
    double CDelta = (C_2 - C_1) / (1 + 0.045 * C_1);
    double HDelta = (H_2 - H_1) / (1 + 0.015 * C_1);
    
    double result = pow(LDelta, 2) + pow(CDelta, 2) + pow(HDelta, 2);
    
    delta = [NSNumber numberWithDouble: sqrt(result)];
    
    return delta;
}

-(NSNumber *) deltaE00: (ColorClass *) colorClass
{
    NSNumber *delta;
    
    // Step 0 - input
    
    double L1 = [L doubleValue];
    double a1 = [a doubleValue];
    double b1 = [bb doubleValue];
    
    double L2 = [colorClass.L doubleValue];
    double a2 = [colorClass.a doubleValue];
    double b2 = [colorClass.bb doubleValue];
    
    // =====
    
    // Step 1 - Calculate C
    
    double C1 = sqrt(pow(a1, 2) + pow(b1, 2));
    double C2 = sqrt(pow(a2, 2) + pow(b2, 2));
    
    // =====
    
    // Step 2 - Calculete a', C' and h'
    
    double C_av = (C1 + C2) / 2;
    
    double G = 0.5 * (1 - sqrt(pow(C_av, 7) / (pow(C_av, 7) + pow(25.0, 7))));
    
    double derL1 = L1;
    double dera1 = (1 + G) * a1;
    double derb1 = b1;
    
    double derL2 = L2;
    double dera2 = (1 + G) * a2;
    double derb2 = b2;
    
    double derC1 = sqrt(pow(dera1, 2) + pow(derb1, 2));
    double derC2 = sqrt(pow(dera2, 2) + pow(derb2, 2));
    
    double derh1;
    double derh2;
    
    if (dera1 == 0 && derb1 == 0) {
        derh1 = 0;
    }
    if (derb1 >= 0) {
        derh1 = atan2(derb1, dera1) * (180.0 / M_PI);
    } else {
        derh1 = atan2(derb1, dera1) * (180.0 / M_PI) + 360;
    }
    
    if (dera2 == 0 && derb2 == 0) {
        derh2 = 0;
    }
    if (derb2 >= 0) {
        derh2 = atan2(derb2, dera2) * (180.0 / M_PI);
    } else {
        derh2 = atan2(derb2, dera2) * (180.0 / M_PI) + 360;
    }
    
    // =====
    
    // Step 3 - Calculate dL', dC', dH', dh'
    
    int dh_Cond;
    
    if ((derh2 - derh1) > 180) {
        dh_Cond = 1;
    }
    if ((derh2 - derh1) < -180) {
        dh_Cond = 2;
    } else {
        dh_Cond = 0;
    }
    
    double dderh = 0.0;
    
    switch (dh_Cond) {
        case 0:
            dderh = derh2 - derh1;
            break;
        case 1:
            dderh = derh2 - derh1 - 360;
            break;
        case 2:
            dderh = derh2 - derh1 + 360;
            break;
            
        default:
            break;
    }
    
    double dderL = derL2 - derL1;
    double dderC = derC2 - derC1;
    
    double dderH = 2 * sqrt(derC1 * derC2) * sin((dderh / 2) * M_PI / 180);
    
    // =====
    
    // Step 4 - Calculate dE2000
    
    double derLav = (derL1 + derL2) / 2;
    double derCav = (derC1 + derC2) / 2;
    
    int h_ave_Cond;
    
    if (derC1 * derC2 == 0) {
        h_ave_Cond = 3;
    }
    if (fabs(derh2 - derh1) <= 180) {
        h_ave_Cond = 0;
    } else if ((derh2 + derh1) < 360) {
        h_ave_Cond = 1;
    } else {
        h_ave_Cond = 2;
    }
    
    double derhav;
    
    switch (h_ave_Cond) {
        case 0:
            derhav = (derh1 + derh2) / 2;
            break;
        case 1:
            derhav = (derh1 + derh2) / 2 + 180;
            break;
        case 2:
            derhav = (derh1 + derh2) / 2 - 180;
            break;
        case 3:
            derhav = derh1 + derh2;
            break;
        default:
            derhav = 0;
            break;
    }
    
    double deravLpowfif = pow((derLav - 50), 2);
    
    double S_L = 1 + (0.015 * deravLpowfif / sqrt(20 + deravLpowfif));
    
    double S_C = 1 + 0.045 * derCav;
    
    double T = 1 - 0.17 * cos((derhav - 30) * M_PI / 180) + 0.24 * cos(2 * derhav * M_PI / 180) + 0.32 * cos((3 * derhav + 6) * M_PI / 180) - 0.2 * cos((4 * derhav - 63) * M_PI / 180);

    double S_H = 1 + 0.015 * derCav * T;
    
    double dTheta = 30 * exp(-1 * pow((derhav - 275) / 25, 2));
    
    double R_C = 2 * sqrt(pow(derCav, 7) / (pow(derCav, 7) + pow(25, 7)));
    
    double R_T = - sin(2 * dTheta * M_PI / 180) * R_C;
    
    double last1 = dderL / S_L / 1;
    
    double last2 = dderC / S_C / 1;
    
    double last3 = dderH / S_H / 1;
    
    double finalDelta2000 = sqrt(pow(last1, 2) + pow(last2, 2) + pow(last3, 2) + R_T * last2 * last3);
    
    delta = [NSNumber numberWithDouble: finalDelta2000];
    
    return delta;
}

@end
