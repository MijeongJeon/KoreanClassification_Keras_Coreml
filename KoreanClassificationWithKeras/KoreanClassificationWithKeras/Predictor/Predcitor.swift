//
//  Predcitor.swift
//  KoreanClassificationWithKeras
//
//  Created by Mijeong Jeon on 22/02/2019.
//  Copyright © 2019 MijeongJeon. All rights reserved.
//

import Foundation
import CoreML

class Predictor {
    private var inputArray: MLMultiArray!
    private let tensorShape: [NSNumber] = [32, 32, 3]
    
    // Init CoreML Array
    public func predict(pixel: CVPixelBuffer?) -> String? {
        inputArray = try? MLMultiArray(shape: tensorShape, dataType: .float32)
        guard let pixelBuffer: CVPixelBuffer = pixel else {
            return nil
        }
        // CoreML Model Initialization and Predict
        let model = hand_written_korean_classification()
        guard let output: hand_written_korean_classificationOutput = try? model.prediction(image: pixelBuffer) else {
            return nil
        }
        return output.classLabel
    }

}

