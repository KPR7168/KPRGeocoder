//
//  ViewController.swift
//  KPRGeocoder-Example
//
//  Created by Ky Pichratanak on 12/16/16.
//  Copyright © 2016 Ky Pichratanak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func latlongToAddress(_ sender: Any) {
        KPRGeocoder().latLongToAddress(latitude: -37.816448,
                                       longitude: 144.961166,
                                       completion: {(result, error) -> Void in
            if error == nil{
                print("address: ", result!)
            }
            else{
                print(error!.description)
            }
        })
    }
    
    @IBAction func addressToLatlong(_ sender: Any) {
        KPRGeocoder().addressToLatLong(address: "49 Balgowlah Avenue, Keysborough VIC 3173, Australia", completion: {(result, error) -> Void in
            if error == nil{
                print("latitude: ", result!.latitude)
                print("longitude: ", result!.longitude)
            }
            else{
                print(error!.description)
            }
        })
    }
    
    @IBAction func distanceBetweenAddresses(_ sender: Any) {
        KPRGeocoder().distance(fromAddress: "49 Balgowlah Avenue, Keysborough VIC 3173, Australia",
                               toAddress: "85–91 Queen Street, Melbourne VIC 3000, Australia",
                               requestUnit: UnitLength.kilometers,
                               completion: {(result, error) -> Void in
            if error == nil{
                print("distance is ", result!, UnitLength.kilometers.symbol)
            }
            else{
                print(error!.description)
            }
        })
    }
    
    @IBAction func distanceBetweenLatlong(_ sender: Any) {
        KPRGeocoder().distance(fromLocation: (-37.816448, 144.961166),
                               toLocation: (-37.817058, 144.996443),
                               requestUnit: UnitLength.kilometers,
                               completion: {(result, error) -> Void in
            if error == nil{
                print("distance is ", result!, UnitLength.kilometers.symbol)
            }
            else{
                print(error!.description)
            }
        })
    }
}

