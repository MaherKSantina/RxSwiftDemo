//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Fatin Jebeili on 4/3/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var products: [Product] = [] {
        didSet {
            updateView()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        ProductName.getAll { list in
            list.forEach { productName in
                ProductDescription.getByID(id: productName.id) { productDescription in
                    self.products.append(.init(id: productName.id, name: productName.name, description: productDescription.description))
                }
            }
        }
    }

    func updateView() {
        tableView?.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let product = products[indexPath.row]
        cell.idLabel.text = String(product.id)
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        vc.product = products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

