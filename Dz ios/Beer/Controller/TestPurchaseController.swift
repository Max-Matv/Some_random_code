//
//  TestPurchaseController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 01.Apr.22.
//

import UIKit

class TestPurchaseController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var beerList = setBeerList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        beerList = setBeerList()
        tableView.reloadData()
    }

    
    @IBAction func nexPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "dzThree")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}
extension TestPurchaseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beerList.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as? TestPurchaseCell {
            cell.setupCell(beer: beerList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TestPurchaseCell
        let value = cell.beerCount.text
        let beer = beerList[indexPath.row]
        beer.count = Int(value!)!
        Bartender.shared.addBeer(beer)
        beerList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
