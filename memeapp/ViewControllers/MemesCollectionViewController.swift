//
//  MemeCollectionViewController.swift
//  memeapp
//
//  Created by Luthfi Abdurrahim on 11/07/21.
//

import UIKit

class MemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties: Non-Outlets
    
    let reusableCollectionCellIdentifier = "memeCellCollection"
        
    
    // MARK: - Collection View Controller Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let numMemes = MemeData.allMemes.count
        let isEmpty = (numMemes == 0)
        
        setUpCollectionViewBackground(isEmpty)
        
        // reload collection to ensure all memes are displayed
        collectionView!.reloadData()
    }        
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        // redraw on rotation so resizes cells properly
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMeme = indexPath.row
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.selectedMeme = MemeData.allMemes[selectedMeme]
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        editorController.modalPresentationStyle = .fullScreen
        present(editorController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Collection View Data Source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let numItems = MemeData.allMemes.count
        
        return numItems
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCollectionCellIdentifier, for: indexPath)
        
        let cellImageView = cell.viewWithTag(1) as! UIImageView
        
        cellImageView.image = MemeData.allMemes[indexPath.row].memedImage
        
        return cell
    }

    
    // MARK: - Utility Functions
    
    func setUpCollectionViewBackground(_ isEmpty: Bool) {
        
        guard let theCollectionView = collectionView else {
            return
        }
               
        let emptyMessageText = "No memes sent yet!\nPress + to create a new meme\nand share it."
        let fontSize: CGFloat = 20.0
        
        if !isEmpty {
            if theCollectionView.backgroundView != nil {
                theCollectionView.backgroundView = nil
            }
        } else {
            if theCollectionView.backgroundView == nil {
                let emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
                emptyMessageLabel.text = emptyMessageText
                emptyMessageLabel.numberOfLines = 0
                emptyMessageLabel.font = UIFont.systemFont(ofSize: fontSize)
                emptyMessageLabel.textColor = UIColor.lightGray
                emptyMessageLabel.textAlignment = .center
                emptyMessageLabel.sizeToFit()
                
                theCollectionView.backgroundView = emptyMessageLabel
            }
        }
    }
    
    
    
}
