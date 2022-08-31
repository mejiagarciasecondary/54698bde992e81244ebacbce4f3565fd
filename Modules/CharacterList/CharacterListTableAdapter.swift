//
//  CharacterListTableAdapter.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import UIKit

protocol CharacterListTableAdapterDataSource: AnyObject {
    var rows: [CharacterCellViewModel] { get }
}

protocol CharacterCellDelegate: AnyObject {
    func characterCellSelected(viewModel: CharacterCellViewModel)
}

final class CharacterListTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    private weak var dataSource: CharacterListTableAdapterDataSource?
    private weak var cellDelegate: CharacterCellDelegate?
    private var tableView: UITableView?

    // MARK: - Adapter life cycle

    init(
        dataSource: CharacterListTableAdapterDataSource?,
        cellDelegate: CharacterCellDelegate?,
        tableView: UITableView?
    ) {
        self.dataSource = dataSource
        self.cellDelegate = cellDelegate
        self.tableView = tableView

        super.init()

        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.rowHeight = 172
        self.tableView?.separatorStyle = .none
        self.tableView?.register(
            UINib(
                nibName: CharacterTableViewCell.identifier,
                bundle: .main
            ),
            forCellReuseIdentifier: CharacterTableViewCell.identifier
        )
    }

    // MARK: - UITableViewDataSource methods

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataSource?.rows.count ?? .zero
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterTableViewCell.identifier,
            for: indexPath
        )

        guard let cell = cell as? CharacterTableViewCell,
              let viewModel = dataSource?.rows[indexPath.row] else {
            return cell
        }

        cell.setup(viewModel: viewModel)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard dataSource?.rows.indices.contains(indexPath.row) == true,
              let viewModel = dataSource?.rows[indexPath.row] else {
            return
        }

        cellDelegate?.characterCellSelected(viewModel: viewModel)
    }
}
