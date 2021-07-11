//
//  TableMemesTableViewController.swift
//  memeapp
//
//  Created by Luthfi Abdurrahim on 11/07/21.
//

import UIKit

class MemesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let tableCellReuseIdentifier = "memeCell"
    
    // MARK: - Table View Controller Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let numMemes = MemeData.allMemes.count
        let isEmpty = (numMemes == 0)
        
        navigationItem.leftBarButtonItem?.isEnabled = !isEmpty
        
        setUpTableViewBackground(isEmpty)

        // reload table to ensure all memes are displayed
        tableView.reloadData()
    }
    
    
    // MARK: - Actions    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        editorController.modalPresentationStyle = .fullScreen
        present(editorController, animated: true, completion: nil)
    }
    
    
    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRows = MemeData.allMemes.count
        return numRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellReuseIdentifier, for: indexPath)
        
        let currentMeme = MemeData.allMemes[indexPath.row]
        
        let cellImageView = cell.viewWithTag(1) as! UIImageView
        cellImageView.image = currentMeme.memedImage
        
        let topText = currentMeme.top
        let bottomText = currentMeme.bottom
        let labelText: String = generateLabelText(topText, bottomText: bottomText)
        
        let cellLabel = cell.viewWithTag(2) as! UILabel
        cellLabel.text = labelText

        return cell
    }
    
    
    // MARK: - Table View Delegate
        
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            MemeData.allMemes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if MemeData.allMemes.count == 0 {
                let editButton = navigationItem.leftBarButtonItem!
                editButton.title = "Edit"
                editButton.isEnabled = false
                
                let isEmpty = true
                setUpTableViewBackground(isEmpty)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMeme = indexPath.row
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.selectedMeme = MemeData.allMemes[selectedMeme]
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    // MARK: - Utility Functions
    
    func setUpTableViewBackground(_ isEmpty: Bool) {
        let emptyMessageText = "No memes sent yet!\nPress + to create a new meme\nand share it."
        let fontSize: CGFloat = 20.0
        
        if !isEmpty {
            if tableView.backgroundView != nil {
                tableView.backgroundView = nil
                tableView.separatorStyle = .singleLine
            }
        } else {
            if tableView.backgroundView == nil {
                let emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
                emptyMessageLabel.text = emptyMessageText
                emptyMessageLabel.numberOfLines = 0
                emptyMessageLabel.font = UIFont.systemFont(ofSize: fontSize)
                emptyMessageLabel.textColor = .lightGray
                emptyMessageLabel.textAlignment = .center
                emptyMessageLabel.sizeToFit()
                
                tableView.backgroundView = emptyMessageLabel
                tableView.separatorStyle = .none
            }
        }
    }
    
    func generateLabelText(_ topText: String, bottomText: String) -> String {
        
        let ellipsis = "..."
        
        let maxNumCharsAvail = 22
        let halfNumCharsAvail = maxNumCharsAvail / 2
        
        let topTextLen = topText.count
        let bottomTextLen = bottomText.count
        
        var remainingCharsAvail = maxNumCharsAvail
        var labelText = ""
                
        if topTextLen <= halfNumCharsAvail {
            labelText += topText
        } else {
            let index = topText.index(topText.startIndex, offsetBy: halfNumCharsAvail)
            labelText += String(topText[..<index])
        }
        
        remainingCharsAvail -= labelText.count
        
        labelText += ellipsis
                
        if bottomTextLen <= remainingCharsAvail {
            labelText += bottomText
        } else {
            if remainingCharsAvail <= halfNumCharsAvail {
                let index = bottomText.index(bottomText.endIndex, offsetBy: -(remainingCharsAvail))
                labelText += String(bottomText[index...])
            } else {
                let numCharsLeftAtFront = remainingCharsAvail - halfNumCharsAvail
                let frontIndex = bottomText.index(bottomText.startIndex, offsetBy: numCharsLeftAtFront)
                labelText += String(bottomText[..<frontIndex])
                                
                labelText += ellipsis
                remainingCharsAvail = halfNumCharsAvail - ellipsis.count
                                
                let backIndex = bottomText.index(bottomText.endIndex, offsetBy: -(remainingCharsAvail))
                labelText += bottomText[backIndex...]
            }
        }
        return labelText
    }
}
