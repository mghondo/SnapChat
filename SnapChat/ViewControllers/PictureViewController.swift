//
//  PictureViewController.swift
//  SnapChat
//
//  Created by Morgan Hondros on 1/6/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        //        let imageData = UIImage.pngData(imageView.image!)
        //        let imageData = imageView.image!.pngData()
        let imageData = imageView.image!.jpegData(compressionQuality: 0.1)!
        
        
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil, completion:{(metadata, error) in
            print("we tried to upload")
            if error != nil{
                print("Error:")
            }else{
                

                // print(metadata?.downloadURL())
                print("I'm HERE")
//                print(StorageReference.downloadURL())
                self.performSegue(withIdentifier: "selectUsersegue", sender: URL.init(dataRepresentation: <#T##Data#>, relativeTo: <#T##URL?#>, isAbsolute: <#T##Bool#>))
            
            }
        
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = descriptionTextField.text!
        
    }
    
}
