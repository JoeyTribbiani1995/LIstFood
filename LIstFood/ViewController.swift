//
//  ViewController.swift
//  LIstFood
//
//  Created by Dũng Võ on 3/9/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate ,UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mealNameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultLabelTextButtonTapped(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //hide the keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    @IBAction func selectImagePhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        mealNameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("error \(info)")
        }
        
        photoImageView.image = selectImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

