//
//  MemeData.swift
//  memeapp
//
//  Created by Luthfi Abdurrahim on 11/07/21.
//

import Foundation
import UIKit

struct MemeData {
    
    // MARK: - Properties: Type ("Class" in other languages)
    
    static var allMemes: [Meme] = (UIApplication.shared.delegate as! AppDelegate).memes
    
            
}
