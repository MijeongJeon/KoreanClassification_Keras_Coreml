//
//  ViewController.swift
//  KoreanClassificationWithKeras
//
//  Created by Mijeong Jeon on 21/02/2019.
//  Copyright © 2019 MijeongJeon. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var drawView: DrawingView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var drawCharacters: String = ""
    
    // MARK: - App Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(predictTheCharacter), name: NSNotification.Name(rawValue: "Predict.Notification"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // MARK: - Button Action
    // 손 글씨 지우기
    @IBAction func clearView(_ sender: Any) {
        let theDrawView: DrawingView = drawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    @IBAction func deleteString(_ sender: UIButton) {
        drawCharacters = ""
        updateResultArea(canDelete: true)
    }
    // MARK: - Prediction
    // 손 글씨 예측하기
    @objc func predictTheCharacter() {
        let pixelToPredict = PixelBuffer().getImagePixel(view: drawView)
        drawCharacters.append(Predictor().predict(pixel: pixelToPredict) ?? "")
        updateResultArea(canDelete: false)
    }
    func updateResultArea(canDelete: Bool) {
        resultLabel.text = drawCharacters
        deleteButton.isHidden = canDelete
    }
}
