//
//  Model.swift
//  RxSwiftDemo
//
//  Created by Fatin Jebeili on 4/3/22.
//

import Foundation

struct ProductName {

    static var table: [ProductName] = [
        .init(
            id: 1,
            name: "Twix"
        ),
        .init(
            id: 2,
            name: "Mars"
        ),
        .init(
            id: 3,
            name: "Snickers"
        ),
        .init(
            id: 4,
            name: "KitKat"
        )
    ]

    var id: Int
    var name: String

    static func getByID(id: Int, completion: ((ProductName) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion?(table.first(where: { $0.id == id })!)
        }
    }

    static func getAll(completion: (([ProductName]) -> Void)?) {
        completion?(table)
    }
}

struct ProductDescription {

    static var table: [ProductDescription] = [
        .init(
            id: 1,
            description: "Twix Description"
        ),
        .init(
            id: 2,
            description: "Mars Description"
        ),
        .init(
            id: 3,
            description: "Snickers Description"
        ),
        .init(
            id: 4,
            description: "KitKat Description"
        )
    ]

    var id: Int
    var description: String

    static func getByID(id: Int, completion: ((ProductDescription) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion?(table.first(where: { $0.id == id })!)
        }
    }

    static func getAll(completion: (([ProductDescription]) -> Void)?) {
        completion?(table)
    }
}

struct Product {
    var id: Int
    var name: String
    var description: String
}
