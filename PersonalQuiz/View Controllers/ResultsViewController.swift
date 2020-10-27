//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 26.10.2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var answers = [Answer]()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        analysisOfAnswers()
    }

    // MARK: - Private methods
    private func analysisOfAnswers() {
    
        // Подсчёт баллов за каждый тип животного в ответах
        var votesForAnimals = [AnimalType : Int]()
        
        answers.forEach { (answer) in
            let animalsOfThisType = answers.filter { $0.type == answer.type }
            votesForAnimals[answer.type] = animalsOfThisType.count
        }
        
        // Максимальное число баллов за один тип животного
        guard let maxCount = votesForAnimals.values.max() else { return }
                
        // Определение результирующего типа животного
        let resultType = votesForAnimals.first(where: { $0.value == maxCount })?.key
                
        if let resultType = resultType {
            showResult(type: resultType)
        }
    }
    
    // Отображение результата
    private func showResult(type: AnimalType) {
        resultTypeLabel.text = "Вы - \(type.rawValue)"
        descriptionLabel.text = type.definition
    }
}
