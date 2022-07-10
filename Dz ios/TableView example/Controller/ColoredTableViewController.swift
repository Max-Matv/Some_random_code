//
//  ColoredTableViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 14.Jun.22.
//

import UIKit

class ColoredTableViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    private let colors: [UIColor] = [.red, .blue, .brown, .gray, .green]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
//        view.backgroundColor = colors[sender.tag]
    }
    
}

extension ColoredTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colors.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ColoredTableViewCell") as? ColoredTableViewCell {
            let colors = colors[indexPath.row]
            cell.button.tag = indexPath.row
            cell.button.backgroundColor = colors
            cell.buttonPressed = {
                self.view.backgroundColor = colors
            }
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.backgroundColor = colors[indexPath.row]
    }

}


extension ColoredTableViewController: CustomCellDelegate {
    func pressButton() {
        
    }
}
