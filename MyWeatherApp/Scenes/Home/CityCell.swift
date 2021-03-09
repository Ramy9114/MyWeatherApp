//
//  CityViewCell.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 08/03/2021.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var forwardImage: UIImageView!
    
    
    func setCity(city: City) {
        cityNameLabel.text = city.name
        forwardImage.image = UIImage(named:"ios-forward-icon")
    }

}
