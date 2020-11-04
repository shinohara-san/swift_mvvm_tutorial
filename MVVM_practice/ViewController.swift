//
//  ViewController.swift
//  MVVM_practice
//
//  Created by Yuki Shinohara on 2020/11/04.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private var models = [Person]()
   
    private let tableView:UITableView = {
            let table = UITableView()
            table.register(PersonFollowingTableViewCell.self,
                           forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
            return table
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        configureModels()
    }
    
    private func configureModels(){
        let names = ["yuki", "yosuke", "maru", "mine", "mari"]
        for name in names {
            models.append(Person(name: name))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.identifier,
                                                       for: indexPath) as? PersonFollowingTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        return cell
    }

}

extension ViewController: PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        //Api callしてバックエンドにデータを保存したり
    }
    
    
}

