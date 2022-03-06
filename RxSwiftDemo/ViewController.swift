//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Fatin Jebeili on 4/3/22.
//

import UIKit
import RxSwift
import RxCocoa

// Extend Reactive entity with our structs to be able to use the .rx notation

extension Reactive where Base == ProductName {
    static var all: Single<[ProductName]> {
        return Single.create { single in
            ProductName.getAll { list in
                single(.success(list))
            }
            return Disposables.create()
        }
    }
}

extension Reactive where Base == ProductDescription {
    static var all: Single<[ProductDescription]> {
        return Single.create { single in
            ProductDescription.getAll { list in
                single(.success(list))
            }
            return Disposables.create()
        }
    }
}

// Let RxSwift know that these entities are reactive compatible
extension ProductName: ReactiveCompatible { }
extension ProductDescription: ReactiveCompatible { }


class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var disposeBag: DisposeBag = .init()


    var productsRelay: BehaviorRelay<[Product]> = BehaviorRelay(value: [])

    var products: [Product] {
        productsRelay.value
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rx.itemSelected
            .subscribe (onNext: { indexPath in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! DetailsViewController
                vc.product = self.products[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        productsRelay.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: TableViewCell.self)) {
                index, product, cell in
                cell.idLabel.text = String(product.id)
                cell.nameLabel.text = product.name
                cell.descriptionLabel.text = product.description
            }
            .disposed(by: disposeBag)

        Observable.zip(
            ProductName.rx.all.asObservable(),
            ProductDescription.rx.all.asObservable()
        ).map { (nameList, descriptionList) in
            return nameList.enumerated().map { (offset, productName) in
                return Product(id: productName.id, name: productName.name, description: descriptionList[offset].description)
            }
        }
        .bind(to: productsRelay)
        .disposed(by: disposeBag)

    }
}
