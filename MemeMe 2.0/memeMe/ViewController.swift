//
//  ViewController.swift
//  memeMe
//
//  Created by Aisha on 10/08/1440 AH.
//  Copyright © 1440 Aisha . All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate {
    
 
    @IBOutlet weak var imagePickingView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var currentTextField: UITextField?
    var picker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        configure(textField: topTextField, withText: "TOP")
        configure(textField: bottomTextField, withText: "BOTTOM")
        shareButton.isEnabled = false
        picker = UIImagePickerController()
        picker.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        subscribeToNotificationObserver()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unubscribeToNotificationObserver()
    }
    
    
    private func configure(textField: UITextField, withText: String){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.strokeWidth: -2,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.paragraphStyle: paragraph
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        textField.defaultTextAttributes = memeTextAttributes
        //textField.text = text
        textField.delegate = self
    }
    
    func pickImage(from source:UIImagePickerController.SourceType){
        picker.sourceType = source
        present(picker, animated: true, completion: nil)
    }
 
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
       pickImage(from: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(from: .photoLibrary)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        currentTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification){
        if bottomTextField.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification){
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notifition: Notification)-> CGFloat {
        let userInfo = notifition.userInfo
        let keyBoardSize = userInfo! [UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyBoardSize.cgRectValue.height
    }
    
     private func subscribeToNotificationObserver() {
    
    NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    private func unubscribeToNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
  
    
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickingView.image!, memedImage:  generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func share(_ sender : Any){
        let sharedImage = generateMemedImage()
        // generate the meme
        let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
            self.save()
        }
    }
    
   
    @IBAction func cancel(_ sender: Any) {
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickingView.image = nil
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        return memedImage
    }
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickingView.image = image
            shareButton.isEnabled = true
        }
        picker.dismiss(animated: true, completion: nil)
    }

}

