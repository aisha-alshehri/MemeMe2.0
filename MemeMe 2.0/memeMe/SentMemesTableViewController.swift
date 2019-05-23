//
//  SentMemesTableViewController.swift
//  memeMe
//
//  Created by Aisha on 26/08/1440 AH.
//  Copyright © 1440 Aisha . All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController
{
    var memes = [Meme]()
  
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let memeController = self.storyboard!.instantiateViewController(withIdentifier: "memeControllerID") as! memeviewcontroller
                
        memeController.sentMemedImage = memes[indexPath.row]
        navigationController!.pushViewController(memeController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCustomCell", for: indexPath) as! TableViewCell
        let memeImage = memes[indexPath.row]
        cell.memeImage.image = memeImage.memedImage
        cell.memeText.text = "\(memeImage.topText)...\(memeImage.bottomText)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
  
}
    
    

