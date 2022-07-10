//
//  MainControllerViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 22.Mar.22.
//

import UIKit

class MainControllerViewController: UIViewController {
  
    private let menuList = Menu.getMenuList()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.dataSource = self
        tableView.delegate = self
        
    }
    


}

extension MainControllerViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "dzCell") as? MainCell {
            cell.setupCell(menu: menuList[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: menuList[indexPath.row].controller, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: menuList[indexPath.row].controller)
            self.navigationController?.pushViewController(vc, animated: true)
    }
}
