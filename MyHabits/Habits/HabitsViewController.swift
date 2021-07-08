//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 13.05.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    private let layout = UICollectionViewFlowLayout()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentHabitViewController))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ]
        NSLayoutConstraint.activate(constraints)
       
    }
    @objc func presentHabitViewController() {
        let HVC = HabitViewController()
        present(HVC, animated: true, completion: nil)
        HVC.delegate = self
    }
    
}
extension HabitsViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
      
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            progressCell.backgroundColor = .white
            progressCell.progressBar.setProgress(HabitsStore.shared.todayProgress, animated: true)
            progressCell.percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
            progressCell.layer.cornerRadius = 10
            
            return progressCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.delegateCell = self
            cell.habit = HabitsStore.shared.habits[indexPath.item]
            if cell.habit?.isAlreadyTakenToday == true {
                cell.button1.tintColor = cell.habit?.color
                cell.button1.backgroundColor = cell.habit?.color
                cell.button1.setImage(.checkmark, for: .normal)
            } else {
                cell.button1.backgroundColor = .clear
                cell.button1.setImage(nil, for: .normal)
            }
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 10
            return cell
        }
    }


}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width: CGFloat = collectionView.frame.width - 16 * 2
            return CGSize(width: width, height: 60)
        } else {
            let width: CGFloat = collectionView.frame.width - 16 * 2
            return CGSize(width: width, height: 130)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            navigationController?.pushViewController(HabitDetailsViewController(habit: habit), animated: true)
    }
  }
}

extension HabitsViewController: ReloadDelegate {
    func reloadCollection() {
        collectionView.reloadData()
        collectionView.reloadInputViews()
        print("Reload collection")
    }
    
    
}
