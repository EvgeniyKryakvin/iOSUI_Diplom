//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 23.06.2021.
//

import UIKit

class HabitDetailsViewController: ViewController {
    
    weak var delegateFromDetailToHabits: ReloadDelegate?
    private lazy var editVC = EditHabitViewController(habit: habit)
    
    private let habitDetailTableView = UITableView(frame: .zero, style: .grouped)
    var habit: Habit
    
    init(habit: Habit){
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        view.backgroundColor = .white
        title = habit.name
        setupDetailTableView()
        editVC.delegateEditToDetail = self
        

    }
    
    @objc func editHabit() {
        navigationController?.present(EditHabitViewController(habit: habit), animated: true, completion: nil)
    }
    
    private func setupDetailTableView() {
        habitDetailTableView.register(HabitDetailTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailTableViewCell.self))
        habitDetailTableView.dataSource = self
        habitDetailTableView.delegate = self
        
        habitDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(habitDetailTableView)
        
        let constraints = [
            habitDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        
        let headerTitle: UILabel = {
            let title = UILabel()
            title.text = "Активность"
            title.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            title.textAlignment = .left
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
        
        header.addSubview(headerTitle)
        let constraints = [
        
            headerTitle.topAnchor.constraint(equalTo: header.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            headerTitle.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            headerTitle.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habitDetailTableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailTableViewCell.self)) as! HabitDetailTableViewCell
        cell.textLabel?.text = HabitsStore.shared.trackDateString(forIndex: indexPath.item)
        let date = HabitsStore.shared.dates[indexPath.item]
        if HabitsStore.shared.habit(habit, isTrackedIn: date ) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    
    
}

extension HabitDetailsViewController: CallFromEditToDetail {
    func callFromEditToDetail() {
        print("Edit to Detail")
        self.delegateFromDetailToHabits?.reloadCollection()
    
    }
    
    
}
