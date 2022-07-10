//
//  TotalController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Apr.22.
//

import UIKit

class TotalController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        proceedsLabel.text = "Выручка: \(Bartender.shared.getTheProceeds())$"
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func endPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Хотите продолжить?", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "да", style: .default) { (action) in
            Bartender.shared.resetProceeds()
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "dzThree") {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        let cancel = UIAlertAction(title: "нет", style: .default) { (action) in
            Bartender.shared.resetAll()
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "main") {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension TotalController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bartender.shared.getBeer().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TotalCell {
            cell.setupCell(beer: Bartender.shared.getBeer()[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    
}
