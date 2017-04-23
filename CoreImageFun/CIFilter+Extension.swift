//
//  CIFilter+Extension.swift
//  CoreImageFun
//
//  Created by tangyuhua on 2017/4/23.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation
import UIKit

extension CIFilter {
    class func logAllFilters() {
        let properties = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        print(properties)
        
        for filterName: String in properties {
            let fltr = CIFilter(name:filterName as String)
            print(fltr!.attributes)
        }
    }
    
    class func oldPhoto(img: CIImage, withAmount intensity: Float) -> CIImage {
        
        
        let beginImage = img;
        // 1
        let sepia = CIFilter(name:"CISepiaTone")!
        sepia.setValue(img, forKey:kCIInputImageKey)
        sepia.setValue(intensity, forKey:"inputIntensity")
        
        // 2
        let random = CIFilter(name:"CIRandomGenerator")!
        
        // 3
        let lighten = CIFilter(name:"CIColorControls")!
        lighten.setValue(random.outputImage, forKey:kCIInputImageKey)
        lighten.setValue(1 - intensity, forKey:"inputBrightness")
        lighten.setValue(0, forKey:"inputSaturation")
        
        // 4
        let croppedImage = lighten.outputImage?.cropping(to: beginImage.extent)
        
        // 5
        let composite = CIFilter(name:"CIHardLightBlendMode")!
        composite.setValue(sepia.outputImage, forKey:kCIInputImageKey)
        composite.setValue(croppedImage, forKey:kCIInputBackgroundImageKey)
        
        // 6
        let vignette = CIFilter(name:"CIVignette")!
        vignette.setValue(composite.outputImage, forKey:kCIInputImageKey)
        vignette.setValue(intensity * 2, forKey:"inputIntensity")
        vignette.setValue(intensity * 30, forKey:"inputRadius")
        
        // 7
        return vignette.outputImage!
    }
    

    
    
}
