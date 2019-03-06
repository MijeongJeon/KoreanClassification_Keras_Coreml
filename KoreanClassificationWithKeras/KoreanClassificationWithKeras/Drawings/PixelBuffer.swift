//
//  PixelBuffer.swift
//  KoreanClassificationWithKeras
//
//  Created by Mijeong Jeon on 22/02/2019.
//  Copyright © 2019 MijeongJeon. All rights reserved.
//

import UIKit

class PixelBuffer: UIView {
    private let imageLength: CGFloat = 32

    // 예측할 이미지 가져오기
    public func getImagePixel(view: UIView) -> CVPixelBuffer? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageLength, height: imageLength), false, 1)
        view.drawHierarchy(in: CGRect(x: 0, y: 0, width: imageLength, height: imageLength), afterScreenUpdates: true)
        var resizedImage = UIImage()
        resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Change image to pixel
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(imageLength), Int(imageLength), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(imageLength), height: Int(imageLength), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: imageLength)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        resizedImage.draw(in: CGRect(x: 0, y: 0, width: imageLength, height: imageLength))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}
