//
//  CieCmfXYZSingleton.h
//  Spectrums comparison
//
//  Created by Kirill Varshamov on 05.02.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Spectrums constants for compute spectrums to XYZ
@interface CieCmfXYZSingleton : NSObject

@property (nonatomic, retain) NSArray *CieCmfXYZArray;

+(CieCmfXYZSingleton*)singleton;

@end

NS_ASSUME_NONNULL_END
