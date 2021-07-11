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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueId = segue.identifier else {
            return
        }
        
        switch segueId {
            
        case "detailViewSegueToEditor":
            // segue is to editor's navigation controller; need to reach its child view controller
            let controller = segue.destination as! MemeEditorViewController
            controller.DEFAULT_TOP_TEXT = selectedMeme.top
            controller.DEFAULT_BOTTOM_TEXT = selectedMeme.bottom
            controller.selectedImage = selectedMeme.image
            
            controller.cameFromDetail = true
            
        default:
            print("unknown segue: \(segueId)")
        }
    }
    
}
