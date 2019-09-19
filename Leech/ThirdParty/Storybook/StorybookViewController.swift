//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit

// MARK: - Decleration
public class StorybookViewController: UIViewController {
    public struct Model {
        public let categories: [StorybookCategory]

        public init(categories: [StorybookCategory]) {
            self.categories = categories
        }

        fileprivate func getItem(at indexPath: IndexPath) -> StorybookItem? {
            return categories
                .getItem(at: indexPath.section)?
                .items
                .getItem(at: indexPath.row)
        }
    }

    public let model: Model

    private let cellIdentifier = "\(UITableViewCell.self)"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()

    public required init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life cycle
extension StorybookViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Layout
extension StorybookViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

    }
}

// MARK: - Actions
extension StorybookViewController {
    private func didTapRow(at indexPath: IndexPath) {
        guard let item = model.getItem(at: indexPath) else { return }

        let viewController = item.classType.testViewController
        present(viewController, animated:  true, completion: nil)
    }
}

// MARK: - UITableViewDatasource
extension StorybookViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return model.categories.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = model.categories.getItem(at: section) else { return 0 }
        return category.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = model.getItem(at: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = item.title

        return cell
    }
}

// MARK: - UITableViewDelegate
extension StorybookViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didTapRow(at: indexPath)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let category = model.categories.getItem(at: section) else { return nil }
        return category.title
    }
}


