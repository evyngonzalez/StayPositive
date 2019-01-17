//
//  GifViewController.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 6/18/17.
//
//

import UIKit

class GifViewController: UIViewController {

    @IBOutlet weak var GifView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GifView.loadGif(name: "sunsetbyevyn")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
