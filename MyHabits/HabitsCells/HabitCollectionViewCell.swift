//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 02.06.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

   
    var habit: Habit? {
        didSet {
            habitName.text = habit?.name
            habitName.textColor = habit?.color
            habitTimeLabel.text = habit?.dateString
            habitCheckButton.layer.borderColor = habit?.color.cgColor
            habitCountDays.text = "Счетчик: \(habit!.trackDates.count)"
        }
    }
    
    private let habitName: UILabel = {
        let habitName = UILabel()
        habitName.font = .systemFont(ofSize: 17, weight: .semibold)
        habitName.translatesAutoresizingMaskIntoConstraints = false
        return habitName
    }()
    
    private let habitTimeLabel: UILabel = {
        let habitTimeLabel = UILabel()
        habitTimeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        habitTimeLabel.textColor = .systemGray2
        habitTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return habitTimeLabel
    }()
    
    private let habitCountDays: UILabel = {
        let habitCountDays = UILabel()
        habitCountDays.font = .systemFont(ofSize: 13, weight: .regular)
        habitCountDays.textColor = .systemGray2
        habitCountDays.translatesAutoresizingMaskIntoConstraints = false
        return habitCountDays
    }()
    
    private let habitCheckButton: UIButton = {
        let habitCheckButton = UIButton()
        habitCheckButton.layer.cornerRadius = 20
        habitCheckButton.layer.borderWidth = 1
        habitCheckButton.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        habitCheckButton.translatesAutoresizingMaskIntoConstraints = false
        return habitCheckButton
    }()
    
    var delegateCell: ReloadDelegate?
    
    @objc func checkHabit() {
        if habit?.isAlreadyTakenToday == true {
            print("Already tracked")
    
        }else{
            HabitsStore.shared.track(habit!)
            self.delegateCell?.reloadCollection()
            print("Not tracked")

            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
   
    private func setupViews() {
        contentView.addSubview(habitName)
        contentView.addSubview(habitTimeLabel)
        contentView.addSubview(habitCountDays)
        contentView.addSubview(habitCheckButton)
        
        let constraints = [
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 6),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            habitCountDays.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitCountDays.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            habitCountDays.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            habitCheckButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitCheckButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            habitCheckButton.widthAnchor.constraint(equalToConstant: 40),
            habitCheckButton.heightAnchor.constraint(equalTo: habitCheckButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
