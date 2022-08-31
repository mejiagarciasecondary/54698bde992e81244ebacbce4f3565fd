//
//  CharacterCellViewModel.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import UIKit

struct CharacterCellViewModel {
    let id: Int?
    let name: String?
    let imageUrlString: String?
    private var queue: DispatchQueue?

    init(
        id: Int?,
        name: String?,
        imageUrlString: String?
    ) {
        self.id = id
        self.name = name
        self.imageUrlString = imageUrlString
    }
}
