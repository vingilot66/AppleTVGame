//
//  MenuViewController.swift
//  Assignment2Game
//
//  Created by Christopher Reynolds on 2019-11-26.
//  Copyright © 2019 Christopher Reynolds. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var myImage : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image: UIImage = UIImage(named: "space.jpg")!
        myImage = UIImageView(image: image)
        myImage?.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        self.view.addSubview(myImage!)
        self.view.sendSubviewToBack(myImage!)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
