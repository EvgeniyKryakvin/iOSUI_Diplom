//
//  EditHabitViewController.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 03.07.2021.
//

import UIKit

class EditHabitViewController: UIViewController {
    weak var delegateEditToDetail: CallFromEditToDetail?

    //MARK: - Create Views
    
    public var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let habitNameLabel: UILabel = {
        let habitName = UILabel()
        habitName.text = "НАЗВАНИЕ"
        habitName.textAlignment = .left
        habitName.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        habitName.textColor = .black
        habitName.translatesAutoresizingMaskIntoConstraints = false
        return habitName
    }()
    
    private let habitTextField: UITextField = {
        let habitTextField = UITextField()
        //habitTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        habitTextField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        habitTextField.textAlignment = .left
        habitTextField.textColor = .black
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        return habitTextField
    }()
    
    private let habitColorName: UILabel = {
        let habitColorName = UILabel()
        habitColorName.text = "ЦВЕТ"
        habitColorName.textAlignment = .left
        habitColorName.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        habitColorName.textColor = .black
        habitColorName.translatesAutoresizingMaskIntoConstraints = false
        return habitColorName
    }()
    
    private let habitColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(selectColor), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let habitTimeLabel: UILabel = {
        let habitTimeLabel = UILabel()
        habitTimeLabel.text = "ВРЕМЯ"
        habitTimeLabel.textAlignment = .left
        habitTimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        habitTimeLabel.textColor = .black
        habitTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return habitTimeLabel
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let localeID = Locale.preferredLanguages.first
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let timeText: UILabel = {
            let date = UILabel()
            date.text =   "Каждый день в "
            date.translatesAutoresizingMaskIntoConstraints = false
            date.font = UIFont.systemFont(ofSize: 17)
            return date
        }()
    
    private let timeTextField: UITextField = {
            let time = UITextField()
            time.translatesAutoresizingMaskIntoConstraints = false
            time.font = UIFont.systemFont(ofSize: 17)
            time.textColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
            time.text = "11:00"
            return time
        }()
    
    private let timeDatePicker: UIDatePicker = {
            let wheel = UIDatePicker()
            wheel.translatesAutoresizingMaskIntoConstraints = false
            wheel.datePickerMode = .time
            wheel.preferredDatePickerStyle = .wheels
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            let date = dateFormatter.date(from: "11:00")
            wheel.date = date!
        wheel.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
            return wheel
        }()
    
    private let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    @objc func deleteButtonPressed() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit.name)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            if let oldHabit = HabitsStore.shared.habits.firstIndex(where: ({$0.name == self.habit.name})) {
                HabitsStore.shared.habits.remove(at: oldHabit)
            }
            self.dismiss(animated: true) {[weak self] in
                self?.delegateEditToDetail?.callFromEditToDetail()
            }
           
        }
        reloadInputViews()
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    private let navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Править")
        let cancelItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelHabit))
        cancelItem.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        let doneItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        doneItem.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
        
    
    @objc func saveHabit() {
            let newHabit = Habit(name: habitTextField.text!, date: timeDatePicker.date, color: habitColorPickerButton.backgroundColor!)
        if let habitIndex = HabitsStore.shared.habits.firstIndex(where: ({$0 == self.habit})) {
            HabitsStore.shared.habits[habitIndex] = newHabit
        }
            reloadInputViews()
            dismiss(animated: true) { [weak self] in
                self?.delegateEditToDetail?.callFromEditToDetail()
            }
    }
    
    @objc func cancelHabit() {
        self.dismiss(animated: true, completion: nil)
        }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
                   let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "HH:mm"
                   timeTextField.text = dateFormatter.string(from: sender.date)
               }
               override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                   self.view.endEditing(true)
               }
    
    //MARK: - Create UIColorPickerViewController
    @objc private func selectColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.supportsAlpha = false
        colorPickerVC.selectedColor = habitColorPickerButton.backgroundColor!
        present(colorPickerVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        habitColorPickerButton.layer.cornerRadius = habitColorPickerButton.frame.height / 2
        
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(habitNameLabel)
        view.addSubview(habitTextField)
        view.addSubview(habitColorName)
        view.addSubview(habitTimeLabel)
        view.addSubview(habitColorPickerButton)
        view.addSubview(timeText)
        view.addSubview(timeTextField)
        view.addSubview(timeDatePicker)
        view.addSubview(navBar)
        view.addSubview(deleteButton)
        
        habitTextField.text = habit.name
        habitTextField.textColor = habit.color
        habitColorPickerButton.backgroundColor = habit.color
        timeTextField.text = habit.dateString
    
        let constraints = [
            habitNameLabel.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 24),
            habitNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            habitTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 10),
            habitTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            habitColorName.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 24),
            habitColorName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitColorName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            habitColorPickerButton.topAnchor.constraint(equalTo: habitColorName.bottomAnchor, constant: 10),
            habitColorPickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitColorPickerButton.widthAnchor.constraint(equalToConstant: 36),
            habitColorPickerButton.heightAnchor.constraint(equalTo: habitColorPickerButton.widthAnchor),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitColorPickerButton.bottomAnchor, constant: 24),
            habitTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            timeText.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 10),
            timeText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            timeTextField.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 10),
            timeTextField.leadingAnchor.constraint(equalTo: timeText.trailingAnchor),
            timeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            timeDatePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 24),
            timeDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
            
            
            
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}


//MARK: - UIColorPicker Delegate
extension EditHabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        habitColorPickerButton.backgroundColor = color
        
    }
    
}
