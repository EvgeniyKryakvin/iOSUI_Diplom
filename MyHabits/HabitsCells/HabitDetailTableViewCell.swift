//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 23.06.2021.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {
    
    private let habitDetailDate: UILabel = {
        let habitDetailDate = UILabel()
        habitDetailDate.font = .systemFont(ofSize: 17, weight: .regular)
        habitDetailDate.textColor = .black
        habitDetailDate.translatesAutoresizingMaskIntoConstraints = false
        return habitDetailDate
    }()
    
    private let habitDetailCheck: UIImageView = {
        let habitDetailCheck = UIImageView()
        habitDetailCheck.image = UIImage(systemName: "checkmark")
        habitDetailCheck.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        return habitDetailCheck
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(habitDetailDate)
        contentView.addSubview(habitDetailCheck)
        
        let constraints = [
        
            habitDetailDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            habitDetailDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitDetailDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            habitDetailCheck.topAnchor.constraint(equalTo: habitDetailDate.topAnchor),
            habitDetailCheck.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            habitDetailCheck.bottomAnchor.constraint(equalTo: habitDetailDate.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
