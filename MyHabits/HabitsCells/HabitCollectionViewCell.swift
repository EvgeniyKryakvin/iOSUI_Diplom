//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 02.06.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private let habitName: UILabel = {
        let habitName = UILabel()
        let store = HabitsStore.shared.habits
        return habitName
    }()
    
}
