//
//  TaskListTableViewCell.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {
    
    static let identifier = ServiceConstants.CellConstants.TaskListCell
    
    private let taskLabel: UILabel = {
        let taskLabel = UILabel()
        taskLabel.textColor = .black
        taskLabel.font = .systemFont(ofSize: 21, weight: .bold)
        return taskLabel
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 21, weight: .bold)
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let colorLabelOfTask: UILabel = {
        let colorLabelOfTask = UILabel()
        colorLabelOfTask.textColor = .white
        colorLabelOfTask.font = .systemFont(ofSize: 20, weight: .bold)
        return colorLabelOfTask
    }()
    
    private let bubbleView: UIView = {
        let bubbleView = UIView()
        bubbleView.backgroundColor = .systemMint
        bubbleView.layer.cornerRadius = 5
        return bubbleView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(taskLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(colorLabelOfTask)
        
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        colorLabelOfTask.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            taskLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 5),
            taskLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bubbleView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bubbleView.widthAnchor.constraint(equalToConstant: 200),
            bubbleView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            colorLabelOfTask.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor),
            colorLabelOfTask.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(task: Task) {
        
        taskLabel.text = task.task
        titleLabel.text = task.title
        descriptionLabel.text = task.description
        colorLabelOfTask.text = "TASK"
        if let colorCodeData = task.colorCode {
            bubbleView.backgroundColor = UIColor(hexString: colorCodeData)
        }
    }
}


