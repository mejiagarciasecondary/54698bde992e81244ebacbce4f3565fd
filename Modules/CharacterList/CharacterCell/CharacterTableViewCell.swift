//
//  CharacterTableViewCell.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {

    // MARK: - UI References

    @IBOutlet private weak var nameLabel: UILabel?

    // MARK: - Cell life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static let identifier = String(
        describing: CharacterTableViewCell.self
    )

    // MARK: - Internal methods

    func setup(viewModel: CharacterCellViewModel) {
        nameLabel?.text = viewModel.name
    }
}
