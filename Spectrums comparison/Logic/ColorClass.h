//
//  ColorClass.h
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 27.01.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorClass : NSObject

@property NSArray *spector, *CieCmfXYZ;
@property NSNumber *R, *G, *B;
@property NSNumber *X, *Y, *Z;
@property NSNumber *L, *a, *bb;

// Single object/light
-(instancetype) initWithSpector: (NSString *) spectorFile;
-(instancetype) initWithObject: (NSString *) spectorFile WithLight: (NSString *) lightFile;

// Palette
-(instancetype) initWithObjectSpectrumsArray: (NSArray *) objectSpectrumsArray;
-(instancetype) initWithObjectSpectrumsArray: (NSArray *) objectSpectrumsArray andLightSpectrumsArray: (NSArray *) lightSpectrumsArray;



-(NSNumber *) deltaE76: (ColorClass *) colorClass;
-(NSNumber *) deltaE94: (ColorClass *) colorClass;
-(NSNumber *) deltaE00: (ColorClass *) colorClass;

@end

NS_ASSUME_NONNULL_END
