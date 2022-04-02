//
//  DzBeerController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import UIKit

class DzBeerController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @IBAction func endPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Конец смены", message: "Завершить смену?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "cancel", style: .destructive)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "totalVc")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        alertController.addAction(cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sellBeer" {
            if let vc = segue.destination as? BeerSellViewController {
                let beer = sender as? Int
                vc.beerIndex = beer
            }
        }
    }

}

extension DzBeerController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "beerCell", for: indexPath) as? BeerCell {
            cell.setupCell(beer: Bartender.shared.getBeer()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Bartender.shared.getBeer().count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = indexPath.row
        self.performSegue(withIdentifier: "sellBeer", sender: selected)

    }
    
}
