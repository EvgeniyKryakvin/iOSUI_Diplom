//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Евгений Кряквин on 02.06.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressTintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 1)
        progressBar.trackTintColor = .systemGray2
        progressBar.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private let progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.text = "Все получится!"
        progressLabel.textColor = .systemGray2
        progressLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        progressLabel.textAlignment = .left
        progressLabel.numberOfLines = 1
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        return progressLabel
    }()
    
    let percentLabel: UILabel = {
        let percentLabel = UILabel()
        //percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        percentLabel.textColor = .systemGray2
        percentLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        percentLabel.textAlignment = .left
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        return percentLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(progressBar)
        contentView.addSubview(progressLabel)
        contentView.addSubview(percentLabel)
        
        let constraints = [
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            progressBar.heightAnchor.constraint(equalToConstant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
