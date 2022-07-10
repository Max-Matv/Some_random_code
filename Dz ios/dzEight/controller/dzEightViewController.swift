//
//  dzEightViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 17.May.22.
//

import UIKit


class dzEightViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
  
    
    @IBAction func buttonPressed(_ sender: Any) {
        let gallery = GalleryView(frame: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 300, height: 400))
        gallery.addImage(image: UIImage(named: "denmark")!)
        view.addSubview(gallery)
    }
    
}
