//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 14.05.2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    var infoView: InfoPage? {
        didSet{
            infoText.text = infoView?.description
        }
    }

    private let infoText: UILabel = {
        let infoText = UILabel()
        infoText.textColor = .black
        infoText.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        infoText.textAlignment = .left
        infoText.numberOfLines = 0
        infoText.translatesAutoresizingMaskIntoConstraints = false
        return infoText
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInfoView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInfoView()
    }
    
    private func setupInfoView() {
        contentView.addSubview(infoText)
        
        let constraints = [
            infoText.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
