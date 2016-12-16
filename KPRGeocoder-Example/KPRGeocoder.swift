//
//  KPRGeocoder.swift
//  KPRGeocoder
//
//  Created by Ky Pichratanak on 12/3/16.
//  Copyright © 2016 Ky Pichratanak. All rights reserved.
//
import CoreLocation
import UIKit

class KPRGeocoder: NSObject{
    
    //MARK: address <-> latlong
    //Convert lat and long to address
    public func latLongToAddress(latitude: Double, longitude: Double, completion:@escaping (_ address: String?, _ e: NSError?) -> Void){
        self.startLoadingAnimation()
        
        let toConvert = CLLocation.init(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(toConvert, completionHandler: {(placemark, error) -> Void in
            if error == nil{
                completion(self.placemarkToAddress(placemark: (placemark?.first)!), nil)
            }
            else{
                completion(nil, error as NSError?)
            }
            
            self.stopLoadingAnimation()
        })
    }
    
    //convert address string into lat long coordinate
    public func addressToLatLong(address: String, completion:@escaping (_ coder: CLLocationCoordinate2D?, _ e: NSError?) -> Void){
        self.startLoadingAnimation()
        
        CLGeocoder().geocodeAddressString(address, completionHandler: {(result,error) -> Void in
            if error == nil{
                completion(result?.first?.location?.coordinate, nil)
            }
            else{
                completion(nil, error as NSError?)
            }
            
            self.stopLoadingAnimation()
        })
    }
    
    //MARK: distance difference
    //find distance between 2 difference address
    public func distance(fromAddress: String, toAddress: String, requestUnit: UnitLength, completion:@escaping (_ distance: Double?, _ e: NSError?) -> Void){
        self.startLoadingAnimation()
        
        self.addressToLatLong(address: fromAddress, completion: {(firstCoordinate, error) -> Void in
            if error == nil{
                self.addressToLatLong(address: toAddress, completion: {(secondCoordinate, error) -> Void in
                    if error == nil{
                        let fromLocation = CLLocation(latitude: (firstCoordinate?.latitude)!, longitude: (firstCoordinate?.longitude)!)
                        let toLocation = CLLocation(latitude: (secondCoordinate?.latitude)!, longitude: (secondCoordinate?.longitude)!)
                        let distanceInMeter = Double(fromLocation.distance(from: toLocation))
                        let distance = NSMeasurement(doubleValue: distanceInMeter, unit: UnitLength.meters)
                        let result = distance.converting(to: requestUnit)
                        
                        completion(result.value, nil)
                    }
                    else{
                        completion(nil, error)
                    }
                })
            }
            else{
                completion(nil, error)
            }
            
            self.stopLoadingAnimation()
        })
    }
    
    //find distance between 2 lat long coordinate
    public func distance(fromLocation: (Double, Double), toLocation: (Double, Double), requestUnit: UnitLength, completion:(_ distance: Double?, _ e: NSError?) -> Void){
        self.startLoadingAnimation()
        
        let fromLocation = CLLocation(latitude: fromLocation.0, longitude: fromLocation.1)
        let toLocation = CLLocation(latitude: toLocation.0, longitude: toLocation.1)
        let distanceInMeter = Double(fromLocation.distance(from: toLocation))
        let distance = NSMeasurement(doubleValue: distanceInMeter, unit: UnitLength.meters)
        
        let result = distance.converting(to: requestUnit)
        
        completion(result.value, nil)
        self.stopLoadingAnimation()
    }
    
    //MARK: status
    
    public func cancelGeocode(){
        CLGeocoder().cancelGeocode()
    }
    
    public func isGeocode() -> Bool{
        return CLGeocoder().isGeocoding
    }
    
    //MARK: activity animation
    
    fileprivate func startLoadingAnimation(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    fileprivate func stopLoadingAnimation(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //MARK: private func
    
    //extract address out of placemark
    fileprivate func placemarkToAddress(placemark: CLPlacemark) -> String{
        let address = placemark.addressDictionary?["FormattedAddressLines"] as? NSMutableArray
        var result = ""
        var index = 0
        
        while index < (address?.count)! {
            let eachItem = address?[index]
            if index == (address?.count)! - 1{
                result = "\(result) \(eachItem!)"
            }
            else{
                result = "\(result) \(eachItem!),"
            }
            
            index += 1
        }
        return result
    }
}
