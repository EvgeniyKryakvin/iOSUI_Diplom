//
//  SecondInfoViewController.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 14.05.2021.
//

import UIKit

class SecondInfoViewController: UIViewController {
    
    //MARK: - Create Views
    private let infoTableView = UITableView(frame: .zero, style: .grouped)
    private let infoTableId = "InfoTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoTableView.separatorStyle = .none
        setupInfoTableConstraints()
        setupInfoTableView()

        
    }
    
    //MARK: - Setup Table
    private func setupInfoTableView() {
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: infoTableId)
        infoTableView.dataSource = self
        infoTableView.delegate = self
    }
    
    //MARK: - Constraints
    private func setupInfoTableConstraints() {
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoTableView)
        
        let constraints = [
            infoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    



}
//MARK: - Data Source
extension SecondInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return InfoStorage.infoTableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoStorage.infoTableModel[section].info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableView.dequeueReusableCell(withIdentifier: infoTableId, for: indexPath) as! InfoTableViewCell
        let infoText = InfoStorage.infoTableModel[indexPath.section].info[indexPath.row]
        cell.infoView = infoText
        return cell
    }
    
    
}

//MARK: - Delegate
extension SecondInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
            
            let infoTextLabel: UILabel = {
                let infoTextLabel = UILabel()
            infoTextLabel.text = "Привычка за 21 день"
            infoTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            infoTextLabel.textColor = .black
            infoTextLabel.textAlignment = .left
            infoTextLabel.backgroundColor = .white
            infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
            
            return infoTextLabel
        }()
        
        header.addSubview(infoTextLabel)
        let constraints = [
            infoTextLabel.topAnchor.constraint(equalTo: header.topAnchor),
            infoTextLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            infoTextLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            infoTextLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
            }
    
}
