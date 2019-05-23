//
//  memeviewcontroller.swift
//  memeMe
//
//  Created by Aisha on 27/08/1440 AH.
//  Copyright © 1440 Aisha . All rights reserved.
//

import Foundation
import UIKit

class memeviewcontroller: UIViewController
{
    
    var sentMemedImage : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView.image = sentMemedImage.memedImage
        tabBarController?.tabBar.isHidden = true
    }
    
    
}

