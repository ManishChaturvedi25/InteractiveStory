//
//  PageControllerViewController.swift
//  InteractiveStory
//
//  Created by ctsuser1 on 4/15/17.
//  Copyright © 2017 ctsuser1. All rights reserved.
//

import UIKit

class PageControllerViewController: UIViewController {

    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    

    var page:Page?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    init(page:Page) {

        self.page = page
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        if let page = page{
            artworkView.image = page.story.artWork

            let attributedString = NSMutableAttributedString(string: page.story.text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString
            //Hook the buttons
            if let firstChoice = page.firstChoice
            {
                firstChoiceButton.setTitle(firstChoice.title, for: .normal)
                firstChoiceButton.addTarget(self, action: #selector(PageControllerViewController.loadFirstChoice), for: .touchUpInside)

            }
            else
            {
                firstChoiceButton.setTitle("Start over Again", for: .normal)
                firstChoiceButton.addTarget(self, action: #selector(PageControllerViewController.playAgain), for: .touchUpInside)
            }

            if let secondChoice = page.secondChoice
            {
                secondChoiceButton.setTitle(secondChoice.title, for: .normal)
                secondChoiceButton.addTarget(self, action: #selector(PageControllerViewController.loadSecondChoice), for: .touchUpInside)

            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artworkView)
        
        artworkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        view.addSubview(storyLabel)
        storyLabel.numberOfLines = 0
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            ])
        
        
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
        
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
    }


    func loadFirstChoice()
    {
        if let page = page, let firstChoice = page.firstChoice{
            
            let nextPage = firstChoice.page
            
            let pageController = PageControllerViewController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
        
    }

    func loadSecondChoice()
    {
        if let page = page, let secondChoice = page.firstChoice{
            
            let nextPage = secondChoice.page
            
            let pageController = PageControllerViewController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
        
    }
    
    func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }

}
