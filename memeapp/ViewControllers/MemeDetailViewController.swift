//
//  MemeDetailViewController.swift
//  memeapp
//
//  Created by Luthfi Abdurrahim on 11/07/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: - Properties (Non-Outlets)
    
    var selectedMeme: Meme!
    
    
    // MARK: - Properties (Outlets)
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedMeme.memedImage
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        navigationItem.title = "Meme Detail"
    }
    
    @objc func editButtonPressed() {
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        editorController.DEFAULT_TOP_TEXT = selectedMeme.top
        editorController.DEFAULT_BOTTOM_TEXT = selectedMeme.bottom
        editorController.selectedImage = selectedMeme.image
        editorController.cameFromDetail = true
        editorController.modalPresentationStyle = .fullScreen
        present(editorController, animated: true, completion: nil)
    }
}
