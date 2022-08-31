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
    @IBOutlet private weak var mainImageView: UIImageView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    // MARK: - Properties

    private var viewModel: CharacterCellViewModel?

    // MARK: - Cell life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
        nameLabel?.text = nil
        mainImageView?.image = nil
        viewModel?.cancelDownload()
        activityIndicator?.startAnimating()
    }

    static let identifier = String(
        describing: CharacterTableViewCell.self
    )

    // MARK: - Internal methods

    func setup(viewModel: CharacterCellViewModel) {
        self.viewModel = viewModel

        nameLabel?.text = viewModel.name

        self.viewModel?.downloadImage { image in
            DispatchQueue.main.async { [weak self] in
                self?.mainImageView?.image = image
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
}
