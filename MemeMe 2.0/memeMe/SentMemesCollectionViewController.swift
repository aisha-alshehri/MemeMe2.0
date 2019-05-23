//
//  SentMemesCollectionViewController.swift
//  memeMe
//
//  Created by Aisha on 26/08/1440 AH.
//  Copyright © 1440 Aisha . All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController
{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes = [Meme]()


    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes
    
    collectionView?.reloadData()
    tabBarController?.tabBar.isHidden = false
}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        super.viewWillTransition(to: size, with: coordinator)
        layout(size: size)
    }
    
    func layout(size: CGSize){
        
        let space: CGFloat = 3.0
        let dimension: CGFloat
        
        dimension = (size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return memes.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCustomCell", for: indexPath) as! CollectionViewCell
        let memeImage = memes[indexPath.row]
        cell.memedImage.image = memeImage.memedImage
        return cell
        
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let memeController = self.storyboard!.instantiateViewController(withIdentifier: "memeControllerID") as! memeviewcontroller
        
        memeController.sentMemedImage = memes[indexPath.row]
        navigationController!.pushViewController(memeController, animated: true)
    }
    
   
}
