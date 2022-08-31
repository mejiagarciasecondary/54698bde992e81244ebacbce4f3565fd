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

    mutating func cancelDownload() {
        queue = nil
    }

    mutating func downloadImage(
        onCompleted: @escaping (UIImage?) -> Void
    ) {
        guard let urlString = imageUrlString,
              let url = URL(string: urlString) else {
            return onCompleted(nil)
        }

        queue = DispatchQueue(label: "image-download")

        queue?.async {
            guard let data = try? Data(contentsOf: url) else {
                return onCompleted(nil)
            }

            guard let image = UIImage(data: data) else {
                return onCompleted(nil)
            }

            onCompleted(image)
        }
    }
}
