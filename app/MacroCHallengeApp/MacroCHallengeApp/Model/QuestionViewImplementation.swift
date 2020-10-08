//
//  QuestionViewImplementation.swift
//  MacroCHallengeApp
//
//  Created by André Papoti de Oliveira on 06/10/20.
//

import Foundation
import UIKit

class QuestionViewImplementation: UIView, QuestionViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionTableView: UITableView!
    
    // MARK: - Dependencies
    var controller: QuestionViewControllerProtocol
    
    // MARK: - Private attributes
    private var question: Question
    private var chosenOption: String?
    
    // MARK: - Init methods
    required init(data: Question, controller: QuestionViewControllerProtocol) {
        self.question = data
        self.controller = controller
        self.chosenOption = nil
        super.init(frame: CGRect.zero)
        initFromNib()
        setupDelegateTableview()
        //translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFromNib() {
        if let nib = Bundle.main.loadNibNamed("QuestionViewImplementation", owner: self, options: nil),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    func overwrite(data: Question) {
        self.question = data
    }
}

extension QuestionViewImplementation: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.question.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionOptionTableViewCell", for: indexPath) as? QuestionOptionTableViewCell {
            let key = String(format: "%c", indexPath.row + 97)
            if let text = self.question.options[key] {
                cell.lblAnswer.text = text
                cell.lblIndex.text = key + ") "
            } else {
                cell.lblAnswer.text = ""
                cell.lblIndex.text = ""
            }
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTextTableViewCell", for: indexPath) as? QuestionTextTableViewCell{
            /// 0 é para o texto da questao, 2 para legenda das imagens e 3 para o subenunciado
            switch indexPath.section {
            case 0:
                cell.lblText.text = self.question.number + ") " + self.question.text
            case 2:
                if let text = self.question.subtitle {
                    cell.lblText.text = text
                } else {
                    cell.isHidden = true
                }
            case 3:
                if let text = self.question.subtitle {
                    cell.lblText.text = text
                } else {
                    cell.isHidden = true
                }
            default:
                cell.lblText.text = "Vei deu ruim"
            }
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionImageTableViewCell", for: indexPath) as? QuestionImageTableViewCell{
            if let images = self.question.images {
                cell.imgQuestionImage.image = images[indexPath.row]
            } else {
                cell.isHidden = true
            }
            
            return cell
        } else {
            let cell = UITableViewCell.init()

            return cell
        }
    }
    
    func setupDelegateTableview() {
        self.questionTableView.delegate = self
        self.questionTableView.dataSource = self
        self.questionTableView.register(UINib(nibName: "QuestionOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionOptionTableViewCell")
        self.questionTableView.register(UINib(nibName: "QuestionImageTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionOptionTableViewCell")
        self.questionTableView.register(UINib(nibName: "QuestionTextTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionOptionTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Enunciado, imagens, legenda, subenunciado, respostas
        return 5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            chosenOption = String(format: "%c", indexPath.row + 97)
            UIView.animate(withDuration: 0.3, animations: {
                cell.CardView.backgroundColor = .green
                cell.lblAnswer.textColor = .white
                cell.lblIndex.textColor = .white
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = questionTableView.cellForRow(at: indexPath) as? QuestionOptionTableViewCell {
            UIView.animate(withDuration: 0.3, animations: {
                cell.CardView.backgroundColor = .white
                cell.lblAnswer.textColor = .black
                cell.lblIndex.textColor = .black
            })
        }
    }
}

