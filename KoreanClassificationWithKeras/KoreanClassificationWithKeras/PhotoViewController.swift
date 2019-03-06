//
//  PhotoViewController.swift
//  KoreanClassificationWithKeras
//
//  Created by Mijeong Jeon on 22/02/2019.
//  Copyright © 2019 MijeongJeon. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 앨범 호출하기
    @IBAction func callAlbum(_ sender: UIButton) {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoView.image = selectedImage
            let pixelToPredict = PixelBuffer().getImagePixel(view: photoView)
            resultLabel.text = Predictor().predict(pixel: pixelToPredict)
        }
        dismiss(animated: true)
    }
}
