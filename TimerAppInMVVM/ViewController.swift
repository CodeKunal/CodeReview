
//
//  ViewController.swift
//  TimerAppInMVVM
//
//  Created by Kunal Arora on 21/12/15.
//  Copyright © 2015 Kunal Arora. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Crashlytics


class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
//    enum StartButton {
//        case Start
//        case Stop
//        case Reset
//    }
//    
//    enum Operator {
//        case Pause
//        case resume
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton(type: UIButtonType.RoundedRect)
//        button.frame = CGRectMake(20, 50, 100, 30)
//        button.setTitle("Crash", forState: UIControlState.Normal)
//        button.addTarget(self, action: "crashButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//        view.addSubview(button)
        pauseButton.enabled = false
        addBorderToButton(startButton)
        addBorderToButton(pauseButton)
        startButton.rx_tap
            .bindTo(viewModel.startTaps)
            .addDisposableTo(disposeBag)
        pauseButton.rx_tap
            .bindTo(viewModel.pauseTaps)
            .addDisposableTo(disposeBag)
        viewModel.timerText.bindTo(timerLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        //This also works well
//        viewModel.timerText.subscribeNext{text in self.timerLabel.text = text}.addDisposableTo(disposeBag)
        
        
        
        
//        viewModel.one.subscribeNext{[weak self] text in
//        self?.startButton.setTitle(text, forState: UIControlState.Normal)
//        }

        
//        viewModel.start
//            .subscribeNext {_ in 
//                self.startButton.setTitle(NSLocalizedString("stop", comment: ""), forState: UIControlState.Normal)
//                self.pauseButton.enabled = true
//            }
//            .addDisposableTo(disposeBag)
//        
//        viewModel.stop
//            .subscribeNext {_ in 
//                
//                self.startButton.setTitle(NSLocalizedString("reset", comment: ""), forState: UIControlState.Normal)
//                self.pauseButton.enabled = false
//            }
//            .addDisposableTo(disposeBag)
//        
//        viewModel.reset
//            .subscribeNext {_ in 
//                self.startButton.setTitle(NSLocalizedString("start", comment: ""), forState: UIControlState.Normal)
//                
//            }
//            .addDisposableTo(disposeBag)
//        
//        viewModel.pause
//            .subscribeNext {_ in 
//                
//                self.pauseButton.setTitle(NSLocalizedString("resume", comment: ""), forState: UIControlState.Normal)
//            }
//            .addDisposableTo(disposeBag)
//        
//        viewModel.resume
//            .subscribeNext {_ in 
//                self.pauseButton.setTitle(NSLocalizedString("pause", comment: ""), forState: UIControlState.Normal)
//                
//            }
//            .addDisposableTo(disposeBag)
        
        viewModel.one.subscribeNext{title in self.startButton.setTitle(title, forState: UIControlState.Normal)}.addDisposableTo(disposeBag)
        
        viewModel.two.subscribeNext{title in self.pauseButton.setTitle(title, forState: UIControlState.Normal)}.addDisposableTo(disposeBag)
        
        viewModel.three.subscribeNext{enabled in self.pauseButton.enabled = enabled}.addDisposableTo(disposeBag)
//        viewModel.one.bindTo(timerLabel.rx_text).addDisposableTo(disposeBag)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ///Adds border to a UIButton
    ///
    ///- Returns: Nothing
    ///
    ///- Parameter button: The  button to which border has to be added
    func addBorderToButton(button:UIButton){
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 75/2
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.blackColor().CGColor
    }
    
//    @IBAction func crashButtonTapped(sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }

    
}

