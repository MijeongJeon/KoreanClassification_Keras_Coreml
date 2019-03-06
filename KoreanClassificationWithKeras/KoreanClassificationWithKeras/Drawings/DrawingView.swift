//
//  DrawingView.swift
//  KoreanClassificationWithKeras
//
//  Created by Mijeong Jeon on 21/02/2019.
//  Copyright © 2019 MijeongJeon. All rights reserved.
//

import UIKit

class Line {
    fileprivate var start: CGPoint
    fileprivate var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }
}

class DrawingView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var timer: Timer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        for line in lines {
            context?.move(to: line.start)
            context?.addLine(to: line.end)
        }
        context?.setLineCap(CGLineCap.round)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(10.0)
        context?.strokePath()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let newPoint: CGPoint = touches.first?.location(in: self) else {
            return
        }
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
        self.setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Predict the image 0.5 seconds after touchesend 
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
    }
    @objc func runTimedCode() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Predict.Notification"), object: nil)
    }
}

