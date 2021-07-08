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
            button1.layer.borderColor = habit?.color.cgColor
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
    
    lazy var button1: UIButton = {
        let button1 = UIButton()
        button1.layer.borderWidth = 1
        button1.layer.cornerRadius = 20
        button1.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        button1.translatesAutoresizingMaskIntoConstraints = false
        return button1
    }()
    
    var delegateCell: ReloadDelegate?
    
    @objc func checkHabit() {
        if habit?.isAlreadyTakenToday == true {
            print("Already tracked")
    
        }else{
            HabitsStore.shared.track(habit!)
            contentView.reloadInputViews()
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
        //contentView.addSubview(habitCheckButton)
        contentView.addSubview(button1)
        
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
            
            button1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            button1.widthAnchor.constraint(equalToConstant: 40),
            button1.heightAnchor.constraint(equalTo: button1.widthAnchor),
            
//            button1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            button1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            button1.widthAnchor.constraint(equalToConstant: 40),
//            button1.heightAnchor.constraint(equalTo: button1.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
