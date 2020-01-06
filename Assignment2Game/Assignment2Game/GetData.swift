//
//  GetData.swift
//  Assignment2Game
//
//  Created by Christopher Reynolds on 2019-11-27.
//  Copyright © 2019 Christopher Reynolds. All rights reserved.
//

import UIKit

class GetData: NSObject {
    
    var dbData: [NSDictionary]?
    let myURL = "http://reynchri.dev.fast.sheridanc.on.ca/mydata/sqlToJson.php" as String
    
    enum JSONError : String, Error{
        case NoData = "Error: No Data"
        case ConversionFailed = "Error: conversion from JSON failed"
        
    }
    
    func jsonParser(){
        guard let endpoint = URL(string: myURL) else{
            print("Error creating connection")
            return
        }
        let request = URLRequest(url: endpoint)
        URLSession.shared.dataTask(with: request){
            (data, response, error) in
            do{
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
                
                guard let data = data else{
                    throw JSONError.NoData
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary]
                    else{
                        throw JSONError.ConversionFailed
                }
                print(json)
                self.dbData = json
            }catch let error as JSONError{
                print(error.rawValue)
            }catch let error as NSError{
                print(error.debugDescription)
            }
            
        }.resume()
        
    }

    /*var dbData : [NSDictionary]?
    let myUrl = "http://reynchri.dev.fast.sheridanc.on.ca/mydata/sqlToJson.php" as String
    
    enum JSONError : String, Error{
        case NoData = "Error: No Data"
        case ConversionFailed = "Error: conversion from JSON failed"
    }
    
    func jsonParser(){
        guard let endpoint = URL(string: myUrl) else{
            print ("Error creating connection")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request) {
            (data,response, error) in
            do {
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
                
                guard let data = data else{
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary]
                    else{
                        throw JSONError.ConversionFailed
                }
                print(json)
                self.dbData = json
            }catch let error as JSONError{
                print(error.rawValue)
            }catch let error as NSError{
                print(error.debugDescription)
            }
        }
    }
    
*/
}


