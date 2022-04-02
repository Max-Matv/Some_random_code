//
//  BeerSellViewController.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import UIKit

class BeerSellViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var beerIndex : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.stepValue = 1.0
        background.image = UIImage(named: Bartender.shared.getBeer()[beerIndex!].background)
        beerImage.image = UIImage(named: Bartender.shared.getBeer()[beerIndex!].image)
        name.text = Bartender.shared.getBeer()[beerIndex!].name
        
    }
    @IBAction func stepered(_ sender: UIStepper) {
        number.text = Int(sender.value).description
    }
    
    @IBAction func sellButtonPressed(_ sender: Any) {
        if Bartender.shared.getBeer()[beerIndex!].count >= Int(number.text!)! {
            Bartender.shared.sellBeer(count: Int(number.text!)!, index: beerIndex!)
            Bartender.shared.putTheProceeds(cost: Bartender.shared.getBeer()[beerIndex!].price, count: Int(number.text!)!)
            navigationController?.popViewController(animated: true)
        }
        
    }
    

}
