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
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var quetionText: UILabel!
    @IBOutlet weak var questionInitialText: UILabel!
    @IBOutlet weak var imagesContainer: UIView!
    @IBOutlet weak var questionSubtitle: UILabel!
    @IBOutlet weak var optionsContainer: UIView!
    
    
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
        setElements()
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
        setElements()
    }
    
    // MARK: - Private functions
    /// Popula a view com base nos parametros da questao recebida
    private func setElements() {
        // Question number
        self.questionNumber.text = self.question.number
        
        //Question text
        self.quetionText.text = self.question.text

        // Question initial text
        if let initialText = self.question.initialText {
            self.questionInitialText.isHidden = false
            self.questionInitialText.text = initialText
        }
        else {
            self.questionInitialText.isHidden = true
        }
        
        // Question images
        if let images = self.question.images {
            self.imagesContainer.isHidden = false
            // Clear previous images
            for view in imagesContainer.subviews {
                view.removeFromSuperview()
            }
            // Add new images
            for img in images {
                createImg(img: img)
            }
        }
        else {
            self.imagesContainer.isHidden = true
        }
        
        // Question subtitle
        if let subtitle = self.question.subtitle {
            self.questionSubtitle.isHidden = false
            self.questionSubtitle.text = subtitle
        }
        else {
            self.questionSubtitle.isHidden = true
        }
        
        // Question options
        // Limpar opções anteriores
        for view in self.optionsContainer.subviews {
            view.removeFromSuperview()
        }
        for option in self.question.options {
            createOption(key: option.key, value: option.value)
        }
    }
    
    /// Cria uma imageView com a imagem especificada e a coloca na view de imagens
    private func createImg(img: UIImage) {
        let imgView = UIImageView(image: img)
        self.imagesContainer.addSubview(imgView)
        //TODO: Constrains
    }
    
    /// Cria um botao com um texto e chaves especificados e a coloca na view de opcoes
    private func createOption(key: String, value: String) {
        let btn = UIButton()
        btn.setTitle(value, for: .normal)
        btn.tag = Int(key) ?? 0
        btn.addTarget(nil, action: #selector(selectOption), for: .touchUpOutside)
        //TODO: Constrains
    }
    
    /// Func. chamada ao selectionar uma opcao
    @objc private func selectOption(sender: UIButton) {
        self.chosenOption = String(sender.tag)
        highlightBg(btn: sender)
    }
    
    /// Trata de representar visualmente para o usuario qual opcao esta selecionada no momento
    func highlightBg(btn: UIButton) {
        for view in self.optionsContainer.subviews {
            if let b = view as? UIButton {
                if b == btn {
                    b.backgroundColor = .green
                }
                else {
                    b.backgroundColor = .clear
                }
            }
        }
    }
    
}

