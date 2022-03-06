//
//  DetailsViewController.swift
//  RxSwiftDemo
//
//  Created by Fatin Jebeili on 4/3/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    var product: Product!


    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        idLabel.text = String(product.id)
        nameLabel.text = product.name
        descriptionLabel.text = product.description
    }
}
